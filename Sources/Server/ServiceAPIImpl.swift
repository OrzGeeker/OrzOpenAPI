//
//  File.swift
//  OrzOpenAPI
//
//  Created by wangzhizhou on 2024/8/8.
//

import Foundation
import OpenAPIRuntime
import OpenAPIVapor
import OpenAPI

// Define a type that conforms to the generated protocol.
struct GreetingServiceAPIImpl: APIProtocol {

    func createUser(_ input: Operations.createUser.Input) async throws -> Operations.createUser.Output {
        return .ok(.init(body: .json(.init(id: "1", name: "Joker", age: 33))))
    }
    
    func getUser(_ input: Operations.getUser.Input) async throws -> Operations.getUser.Output {
        return .ok(.init(body: .json(.init(id: "1", name: "Joker", age: 33))))
    }
    
    func updateUser(_ input: Operations.updateUser.Input) async throws -> Operations.updateUser.Output {
        return .ok(.init(body: .json(.init(id: "1", name: "Joker", age: 33))))
    }
    
    func deleteUser(_ input: Operations.deleteUser.Input) async throws -> Operations.deleteUser.Output {
        return .ok(.init())
    }
    
    func getAllUser(_ input: Operations.getAllUser.Input) async throws -> Operations.getAllUser.Output {
        return .ok(.init(body: .json([.init(id: "1", name: "joker", age: 33)])))
    }
    
}
