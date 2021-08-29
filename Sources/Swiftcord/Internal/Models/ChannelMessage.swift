//
//  ChannelMessage.swift
//  Swiftcord
//
//  Created by Patrick Gatewood on 8/28/21.
//

import Foundation

/// https://discord.com/developers/docs/resources/channel#message-object
public struct ChannelMessage: Codable {
    public let id: Snowflake
    public let channelID: Snowflake
    public let author: User?
    public let content: String
//    public let timestamp: Date
    // attachments
    // mentions
    // emdedded content
    // reactions
    
    enum CodingKeys: String, CodingKey {
        case channelID = "channel_id"
        case id, author, content
    }
}
