//
//  GetChannelMessagesRequest.swift
//  Swiftcord
//
//  Created by Patrick Gatewood on 8/28/21.
//

import Foundation

public struct GetChannelMessagesRequest: APIRequest {
    public typealias Response = [ChannelMessage]
    
    public let channelID: Snowflake
    public var path: String {
        "/channels/\(channelID)/messages"
    }
    
    public init(channelID: Snowflake) {
        self.channelID = channelID
    }
}
