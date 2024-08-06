import OpenAPIRuntime
import OpenAPIURLSession
import OpenAPI

@main
struct OrzClient {

    static func main() async throws {

        let client = Client(serverURL: try Servers.server2(), transport: URLSessionTransport())
        
        let response = try await client.getGreeting(query: .init(name: "CLI"))
        
        switch response {
        case .ok(let okResponse):
            switch okResponse.body {
            case .json(let greeting):
                print(greeting.message)
            }
        case .undocumented(statusCode: let statusCode, _):
            print("🥺 undocumented response: \(statusCode)")
        }
        
        while let input = readLine() {
            if input == "q" {
                break
            }
        }
    }
}
