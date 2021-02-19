//
//  GuildMembersChunk.swift
//  DiscordVoice
//
//  Created by Patrick Gatewood on 2/9/21.
//

import Foundation

/// https://discord.com/developers/docs/topics/gateway#guild-members-chunk
public struct GuildMembersChunk: Codable, Hashable, Equatable {
    public let guildID: Snowflake
    public let members: [GuildMember]
    
    // TODO: handle pagination for large guilds
    enum CodingKeys: String, CodingKey {
        case guildID = "guild_id"
        case members
    }
}
