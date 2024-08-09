//
//  ServiceImpl.swift
//  OrzOpenAPI
//
//  Created by wangzhizhou on 2024/8/8.
//

import Foundation
import OpenAPIRuntime
import OpenAPIVapor
import OpenAPI
import Dependencies
import Fluent

// Define a type that conforms to the generated protocol.
struct ServiceImpl: APIProtocol {
    
    @Dependency(\.request) var request
    
    func createUser(_ input: Operations.createUser.Input) async throws -> Operations.createUser.Output {
        let user = try request.content.decode(User.self)
        try await user.save(on: request.db)
        return .ok(.init(body: .json(user.apiUser)))
    }
    
    func getUser(_ input: Operations.getUser.Input) async throws -> Operations.getUser.Output {
        guard let user = try await User.find(request.parameters.get("userID"), on: request.db)
        else {
            return .notFound(.init())
        }
        return .ok(.init(body: .json(user.apiUser)))
    }
    
    func updateUser(_ input: Operations.updateUser.Input) async throws -> Operations.updateUser.Output {
        let updateUser = try request.content.decode(User.self)
        guard let user = try await User.find(request.parameters.get("userID"), on: request.db)
        else {
            return .notFound(.init())
        }
        
        user.name = updateUser.name
        user.age = updateUser.age
        
        try await user.save(on: request.db)
        
        return .ok(.init(body: .json(user.apiUser)))
    }
    
    func deleteUser(_ input: Operations.deleteUser.Input) async throws -> Operations.deleteUser.Output {
        guard let user = try await User.find(request.parameters.get("userID"), on: request.db)
        else {
            return .notFound(.init())
        }
        try await user.delete(on: request.db)
        return .ok(.init())
    }
    
    func getAllUser(_ input: Operations.getAllUser.Input) async throws -> Operations.getAllUser.Output {
        guard let search = request.query[String.self, at: "search"] else {
            let users = try await User.query(on: request.db).all().compactMap { $0.apiUser }
            return .ok(.init(body: .json(users)))
        }
        let users = try await User.query(on: request.db).filter(\.$name == search).all().compactMap { $0.apiUser }
        return .ok(.init(body: .json(users)))
    }
}
