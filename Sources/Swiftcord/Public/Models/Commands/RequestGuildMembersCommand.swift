//
//  RequestGuildMembersCommand.swift
//  DiscordVoice
//
//  Created by Patrick Gatewood on 11/30/20.
//

import Foundation

/// https://discord.com/developers/docs/topics/gateway#request-guild-members-guild-request-members-structure
public struct RequestGuildMembersCommand: Codable {
    public let guildID: Snowflake
    public let query: String = ""
    public let limit: Int = 0
    public let presences: Bool = true
    
    enum CodingKeys: String, CodingKey {
        case guildID = "guild_id"
        case query
        case limit, presences
    }
}
