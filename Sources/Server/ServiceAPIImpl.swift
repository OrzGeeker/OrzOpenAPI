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
