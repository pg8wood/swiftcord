//
//  User.swift
//  DiscordVoice
//
//  Created by Patrick Gatewood on 11/24/20.
//

import Foundation

public struct User: Codable, Hashable, Equatable {
    public let id: Snowflake
    public let username: String
    public let avatar: String?
    
    public init(id: Snowflake, username: String, avatar: String?) {
        self.id = id
        self.username = username
        self.avatar = avatar
    }
}
