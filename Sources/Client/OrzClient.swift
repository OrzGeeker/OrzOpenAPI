
import OpenAPI
import OpenAPIRuntime
import OpenAPIURLSession

@main
struct OrzClient {
    
    static let client = Client(serverURL: try! Servers.server1(), transport: URLSessionTransport())

    static func main() async throws {

        print("Requst All Users Before Create Any User:")
        try await requestAllUsers()
        
        print("Create A User:")
        try await requestCreateUser()
        
        print("Requst All Users After Create An User:")
        try await requestAllUsers()

        while let input = readLine() {
            if input == "q" {
                break
            }
        }
    }
    
    static func requestAllUsers() async throws {
        // 请求全部用户信息
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
    }
    
    static func requestCreateUser() async throws {
        
        let response = try await client.createUser(.init(body: .json(.init(name: "tim", age: 32))))
        switch response {
        case .ok(let okResponse):
            switch okResponse.body {
            case .json(let user):
                print(user)
            }
        case .undocumented(statusCode: let statusCode, _):
            print("🥺 undocumented response: \(statusCode)")
        }
    }
}
