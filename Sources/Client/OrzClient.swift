import OpenAPIRuntime
import OpenAPIURLSession
import OpenAPI

@main
struct OrzClient {

    static func main() async throws {

        let client = Client(serverURL: try Servers.server1(), transport: URLSessionTransport())
        
        let response = try await client.getUser(.init(path: .init(userID: "1")))
        
        switch response {
        case .ok(let okResponse):
            switch okResponse.body {
            case .json(let user):
                print(user)
            }
        case .notFound(let resp):
            print("User Not Found")
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
