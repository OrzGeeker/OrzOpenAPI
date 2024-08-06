//
//  User.swift
//  OrzOpenAPI
//
//  Created by wangzhizhou on 2024/8/8.
//

import Vapor
import Fluent
import Foundation

final class User: Model, @unchecked Sendable {
    
    static let schema: String = "user"
    
    @ID
    var id: UUID?
    
    @Field(key: "name")
    var name: String?
    
    @Field(key: "age")
    var age: Int?
    
    init(id: UUID? = nil, name: String? = nil, age: Int? = nil) {
        self.id = id
        self.name = name
        self.age = age
    }
    
    init() {}
}
 

extension User: AsyncMigration {
    
    func prepare(on database: any FluentKit.Database) async throws {
        try await database.schema(User.schema)
            .id()
            .field("name", .string)
            .field("age", .int)
            .create()
    }
    
    func revert(on database: any Database) async throws {
        try await database.schema(User.schema)
            .delete()
    }
}

extension User: Content {}
