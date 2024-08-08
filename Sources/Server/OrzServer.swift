import Foundation
import Vapor
import OpenAPI
import OpenAPIVapor
import Fluent
import FluentSQLiteDriver

@main
struct OrzServer {
    static func main() async throws {
        
        // Create your Vapor application.
        let app = try await Vapor.Application.make()
                
        // Create a VaporTransport using your application.
        let requestInjectionMiddleware = OpenAPIRequestInjectionMiddleware()
        let transport = VaporTransport(routesBuilder: app.grouped(requestInjectionMiddleware))
        
        // Create an instance of your handler type that conforms the generated protocol
        // defininig your service API.
        let handler = GreetingServiceAPIImpl()
        
        // Call the generated function on your implementation to add its request
        // handlers to the app.
        try handler.registerHandlers(on: transport, serverURL: Servers.server2())
        
        // Add Sqlite Memory Database for Demo Server
        app.databases.use(.sqlite(.memory), as: .sqlite)
        app.migrations.add(User())
        try await app.autoMigrate()
        
        // Add Vapor middleware to serve the contents of the Public/ directory.
        app.middleware.use(FileMiddleware(publicDirectory: app.directory.publicDirectory))
        
        // Redirect /openapi to openapi.html, which serves the rendered documentation.
        app.get("openapi") { $0.redirect(to: "/openapi.html") }
        
        // Start the app as you would normally.
        try await app.execute()
    }
}
