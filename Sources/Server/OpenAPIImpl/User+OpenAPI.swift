//
//  User+OpenAPI.swift
//  OrzOpenAPI
//
//  Created by wangzhizhou on 2024/8/8.
//

import OpenAPI
import Foundation

extension Components.Schemas.User {
    
    var dbUser: User? {
        var uuid: UUID?
        if let uuidString = self.uuid {
            uuid = UUID(uuidString: uuidString)
        }
        return User(id: uuid, name: self.name, age: self.age)
    }
}

extension User {
    
    var apiUser: Components.Schemas.User {
        return .init(uuid: id?.uuidString, name: name, age: age)
    }
}
