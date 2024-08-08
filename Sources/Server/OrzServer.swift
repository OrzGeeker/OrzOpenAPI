import Foundation
import Vapor
import Fluent
import FluentSQLiteDriver
import OpenAPIRuntime
import OpenAPIVapor
import OpenAPI

// Define a type that conforms to the generated protocol.
struct GreetingServiceAPIImpl: APIProtocol {
    func getGreeting(
        _ input: Operations.getGreeting.Input
    ) async throws -> Operations.getGreeting.Output {
        let name = input.query.name ?? "Stranger"
        let greeting = Components.Schemas.Greeting(message: "Hello, \(name)!")
        return .ok(.init(body: .json(greeting)))
    }


    func getEmoji(
        _ input: Operations.getEmoji.Input
    ) async throws -> Operations.getEmoji.Output {
        let emojis = "👋👍👏🙏🤙🤘"
        let emoji = String(emojis.randomElement()!)
        return .ok(.init(body: .plainText(.init(emoji))))
    }
}

@main
struct OrzServer {
    static func main() async throws {
        
        // Create your Vapor application.
        let app = try await Vapor.Application.make()
        
        // Create a VaporTransport using your application.
        let transport = VaporTransport(routesBuilder: app)
        
        // Create an instance of your handler type that conforms the generated protocol
        // defininig your service API.
        let handler = GreetingServiceAPIImpl()
        
        // Call the generated function on your implementation to add its request
        // handlers to the app.
        try handler.registerHandlers(on: transport, serverURL: Servers.server3())
        
        // Add Sqlite Memory Database for Demo Server
        app.databases.use(.sqlite(.memory), as: .sqlite)
        try await app.autoMigrate()
        
        // Add Vapor middleware to serve the contents of the Public/ directory.
        app.middleware.use(FileMiddleware(publicDirectory: app.directory.publicDirectory))
        
        // Redirect /openapi to openapi.html, which serves the rendered documentation.
        app.get("openapi") { $0.redirect(to: "/openapi.html", redirectType: .permanent) }
        
        // Start the app as you would normally.
        try await app.execute()
    }
}
