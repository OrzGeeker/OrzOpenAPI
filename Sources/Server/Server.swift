import Fluent
import FluentSQLiteDriver
import Foundation
import OpenAPI
import OpenAPIVapor
import Vapor

@main
struct Server {
    static func main() async throws {

        // Create your Vapor application.
        let app = try await Vapor.Application.make()

        // Create a VaporTransport using your application.
        let requestInjectionMiddleware = RequestInjectionMiddleware()
        let transport = VaporTransport(
            routesBuilder: app.grouped(requestInjectionMiddleware)
        )

        // Create an instance of your handler type that conforms the generated protocolhttp://127.0.0.1:8080/
        // defininig your service API.
        let handler = ServiceImpl()

        // Call the generated function on your implementation to add its request
        // handlers to the app.
        try handler
            .registerHandlers(on: transport, serverURL: Servers.Server2.url())

        // Add Sqlite Memory Database for Demo Server
        app.databases.use(.sqlite(.memory), as: .sqlite)
        app.migrations.add(User())
        try await app.autoMigrate()

        // Add Vapor middleware to serve the contents of the Public/ directory.
        app.middleware
            .use(FileMiddleware(publicDirectory: app.directory.publicDirectory))

        // Redirect /openapi to openapi.html, which serves the rendered documentation.
        let openapi = app.grouped("openapi")
        openapi.get { $0.redirect(to: "/openapi/editor/next") }
        openapi.get("doc") { $0.redirect(to: "/openapi.html") }
        openapi.get("editor") { $0.redirect(to: "/swagger_editor.html") }
        openapi.get("editor", "next") {
            $0.redirect(to: "/swagger_editor_next.html")
        }
        // Resume of people
        let resume = app.grouped("resume")
        resume.get("wangzhizhou") { $0.redirect(to: "/resume/wangzhizhou.pdf") }
        // home page
        app.get { $0.redirect(to: "openapi") }

        // Start the app as you would normally.
        try await app.execute()
    }
}
