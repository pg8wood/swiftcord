//
//  ReadyPayload.swift
//  DiscordVoice
//
//  Created by Patrick Gatewood on 11/25/20.
//

import Foundation

/// https://discord.com/developers/docs/topics/gateway#ready
public struct ReadyPayload: Codable, Hashable, Equatable {
    public let gatewayVersion: Int
    public let user: User
    public let sessionID: String
    
    public init(gatewayVersion: Int, user: User, sessionID: String) {
        self.gatewayVersion = gatewayVersion
        self.user = user
        self.sessionID = sessionID
    }
    
    enum CodingKeys: String, CodingKey {
        case gatewayVersion = "v"
        case sessionID = "session_id"
        case user
    }
}
