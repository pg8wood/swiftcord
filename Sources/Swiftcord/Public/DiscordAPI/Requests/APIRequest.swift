//
//  APIRequest.swift
//  DiscordVoice
//
//  Created by Patrick Gatewood on 11/24/20.
//

import Foundation

public protocol APIRequest {
    associatedtype Response
    
    var baseURL: URL { get }
    var headers: [String: String] { get }
    var path: String { get }
    
    func decodeResponse(from data: Data) throws -> Response
}

public extension APIRequest {
    var baseURL: URL {
        URL(string: "https://discord.com/api")!
    }
    
    var headers: [String: String] {
        [
            "Authorization": "Bot \(Swiftcord.discordToken)"
        ]
    }
}

extension APIRequest where Response: Decodable {
    public func decodeResponse(from data: Data) throws -> Response {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        return try decoder.decode(Response.self, from: data)
    }
}
