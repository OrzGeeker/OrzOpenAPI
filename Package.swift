// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "OrzOpenAPI",
    platforms: [
        .macOS(.v10_15),
        .iOS(.v12),
        .watchOS(.v4),
        .tvOS(.v12),
        .visionOS(.v1),
    ],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .executable(name: "client", targets: ["Client"]),
        .executable(name: "server", targets: ["Server"]),
        .library(name: "OrzOpenAPI", targets: ["OpenAPI"]),
    ],
    dependencies: [
        // For OpenAPI Generator
        .package(url: "https://github.com/apple/swift-openapi-generator", from: "1.0.0"),
        .package(url: "https://github.com/apple/swift-openapi-runtime", from: "1.0.0"),
        // For Server
        .package(url: "https://github.com/swift-server/swift-openapi-vapor.git", from: "1.0.1"),
        // For Server Database
        .package(url: "https://github.com/vapor/fluent.git", from: "4.11.0"),
        .package(url: "https://github.com/vapor/fluent-sqlite-driver.git", from: "4.7.4"),
        .package(url: "https://github.com/pointfreeco/swift-dependencies", from: "1.0.0"),
        // For Client
        .package(url: "https://github.com/apple/swift-openapi-urlsession", from: "1.0.0"),
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .executableTarget(name: "Client", dependencies: [
            "OpenAPI",
            .product(name: "OpenAPIURLSession", package: "swift-openapi-urlsession"),
        ]),
        .executableTarget(name: "Server", dependencies: [
            "OpenAPI",
            .product(name: "OpenAPIVapor", package: "swift-openapi-vapor"),
            .product(name: "Fluent", package: "fluent"),
            .product(name: "FluentSQLiteDriver", package: "fluent-sqlite-driver"),
            .product(name: "Dependencies", package: "swift-dependencies"),
        ]),
        .target(
            name: "OpenAPI",
            dependencies: [
                .product(name: "OpenAPIRuntime", package: "swift-openapi-runtime"),
            ],
            resources: [
                .copy("openapi.yml"),
                .copy("openapi-generator-config.yaml")
            ],
            plugins: [
                .plugin(name: "OpenAPIGenerator", package: "swift-openapi-generator"),
            ]
        ),
        .testTarget(
            name: "OpenAPITests",
            dependencies: ["OpenAPI"]),
    ]
)
