# OrzOpenAPI

Use Swift OpenAPI Generator to develop Client & Server。**This is a template project**

## Development

- Clone the Repo

    ```bash
    git clone https://github.com/OrzGeeker/OrzOpenAPI.git && cd OrzOpenAPI
    ```

- Run the Server: `swift run server`

    ```
    Building for debugging...
    [1/1] Write swift-version--4A847ED0836F2485.txt
    Build of product 'server' complete! (0.48s)
    2025-03-14T18:48:18+0800 info codes.vapor.application : database-id=sqlite migration=Server.User [FluentKit] [Migrator] Starting prepare
    2025-03-14T18:48:18+0800 info codes.vapor.application : database-id=sqlite migration=Server.User [FluentKit] [Migrator] Finished prepare
    2025-03-14T18:48:18+0800 notice codes.vapor.application : [Vapor] Server started on http://127.0.0.1:8080
    ```

- Show the Server EndPoints: `swift run server routes`

    ```
    +--------+----------------------+
    | POST   | /api/user            |
    +--------+----------------------+
    | GET    | /api/user/:userID    |
    +--------+----------------------+
    | PUT    | /api/user/:userID    |
    +--------+----------------------+
    | DELETE | /api/user/:userID    |
    +--------+----------------------+
    | GET    | /api/users           |
    +--------+----------------------+
    | GET    | /openapi             |
    +--------+----------------------+
    | GET    | /openapi/editor      |
    +--------+----------------------+
    | GET    | /openapi/editor/next |
    +--------+----------------------+
    | GET    | /                    |
    +--------+----------------------+
    ```

- Run the Client: `swift run client`
    
    ```
    Building for debugging...
    [1/1] Write swift-version--4A847ED0836F2485.txt
    Build of product 'client' complete! (0.30s)
    Requst All Users Before Create Any User:
    [OpenAPI.Components.Schemas.User(uuid: Optional("4C537DC4-7883-4AD9-8239-C43E3A890AC7"), name: Optional("tim"), age: Optional(32))]
    Create A User:
    User(uuid: Optional("F9FBAA5B-411D-4612-8F03-D8273CA4E238"), name: Optional("tim"), age: Optional(32))
    Requst All Users After Create An User:
    [OpenAPI.Components.Schemas.User(uuid: Optional("4C537DC4-7883-4AD9-8239-C43E3A890AC7"), name: Optional("tim"), age: Optional(32)), OpenAPI.Components.Schemas.User(uuid: Optional("F9FBAA5B-411D-4612-8F03-D8273CA4E238"), name: Optional("tim"), age: Optional(32))]
    ```

- Run the Tests: `swift test`

    ```
    Building for debugging...
    [120/120] Compiling swift_openapi_generator GenerateOptions.swift
    Build complete! (5.80s)
    Test Suite 'All tests' started at 2025-03-14 18:50:25.632.
    Test Suite 'All tests' passed at 2025-03-14 18:50:25.635.
            Executed 0 tests, with 0 failures (0 unexpected) in 0.000 (0.002) seconds
    􀟈  Test run started.
    􀄵  Testing Library Version: 4399cba961ad04adc45f533d0c1a950e6670e7e1
    􀟈  Test example() started.
    􁁛  Test example() passed after 0.001 seconds.
    􁁛  Test run with 1 test passed after 0.001 seconds.
    ```

## Links

- [Swift Package Index](https://swiftpackageindex.com/)

- [swift-openapi-generator](https://swiftpackageindex.com/apple/swift-openapi-generator)

- [swift-openapi-generator文档](https://swiftpackageindex.com/apple/swift-openapi-generator/1.3.0/documentation/swift-openapi-generator)

- [Swift On Server Guides](https://www.swift.org/documentation/server/guides/)

- [Swagger Doc](https://swagger.io/docs/)

- [Swagger Editor](https://github.com/swagger-api/swagger-editor)

- [SwaggerUI](https://github.com/swagger-api/swagger-ui)
