//
//  Channel.swift
//  DiscordVoice
//
//  Created by Patrick Gatewood on 2/9/21.
//

import Foundation

/// https://discord.com/developers/docs/resources/channel#channel-object
struct ChannelPayload: Codable, Hashable {
    let id: Snowflake
    let type: ChannelType
    let guildID: Snowflake?
    let name: String?
    let position: Int?
    let parentID: Snowflake?
    
    enum CodingKeys: String, CodingKey {
        case guildID = "guild_id"
        case parentID = "parent_id"
        case id, type, name, position
    }
}
