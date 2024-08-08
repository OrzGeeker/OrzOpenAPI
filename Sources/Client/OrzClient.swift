import OpenAPIRuntime
import OpenAPIURLSession
import OpenAPI

@main
struct OrzClient {

    static func main() async throws {

        let client = Client(serverURL: try Servers.server1(), transport: URLSessionTransport())
        
        let response = try await client.getAllUser(.init())
        
        switch response {
        case .ok(let okResponse):
            switch okResponse.body {
            case .json(let user):
                print(user)
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
