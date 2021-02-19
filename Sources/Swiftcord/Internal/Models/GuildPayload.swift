//
//  GuildPayload.swift
//  DiscordVoice
//
//  Created by Patrick Gatewood on 11/24/20.
//

import Foundation

/// https://discord.com/developers/docs/resources/guild#guild-object
struct GuildPayload: Codable, Hashable, Equatable, Identifiable {
    let id: Snowflake
    let name: String
    let icon: String?
    let voiceStates: [VoiceState]
    let members: [GuildMember]
    let channels: [ChannelPayload]
    
    enum CodingKeys: String, CodingKey {
        case voiceStates = "voice_states"
        case id, name, icon, members, channels
    }
}
