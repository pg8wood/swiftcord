//
//  IdentifyCommand.swift
//  DiscordVoice
//
//  Created by Patrick Gatewood on 11/24/20.
//

import Foundation

public struct IdentifyCommand: Codable {
    struct ConnectionProperties: Codable {
        let os: String
        let browser: String
        let device: String
        
        enum CodingKeys: String, CodingKey {
            case os = "$os"
            case browser = "$browser"
            case device = "$device"
        }
    }
    
    let token: String
    var properties = ConnectionProperties(os: "iOS", browser: "testing", device: "testing")
    var intents: Int = 32671 // https://discord.com/developers/docs/topics/gateway#list-of-intents | Intent calculator: https://ziad87.net/intents/
}
