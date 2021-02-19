//
//  VoiceState.swift
//  
//
//  Created by Patrick Gatewood on 2/19/21.
//

import Foundation

/// https://discord.com/developers/docs/resources/voice#voice-state-object
public struct VoiceState: Codable, Hashable, Equatable {
    public let guildID: Snowflake?
    public let userID: Snowflake
    public let channelID: Snowflake?
    public let member: GuildMember?
    
    public init(
        guildID: Snowflake?,
        userID: Snowflake,
        channelID: Snowflake?,
        member: GuildMember?) {
        
        self.guildID = guildID
        self.userID = userID
        self.channelID = channelID
        self.member = member
    }
    
    enum CodingKeys: String, CodingKey {
        case guildID = "guild_id"
        case userID = "user_id"
        case channelID = "channel_id"
        case member
    }
}

public struct GuildMember: Codable, Hashable, Equatable {
    let user: User?
    
    public init(user: User?) {
        self.user = user
    }
}
