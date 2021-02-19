//
//  GetGuildIconRequest.swift
//  DiscordVoice
//
//  Created by Patrick Gatewood on 2/7/21.
//

#if os(iOS)
import UIKit
#elseif os(macOS)
import AppKit
#endif

public struct GetGuildIconRequest: APIRequest {
    #if os(iOS)
    public typealias Response = UIImage
    #elseif os(macOS)
    public typealias Response = NSImage
    #endif

    public let guildID: Snowflake
    public let iconHash: String
    
    public let baseURL = URL(string: "https://cdn.discordapp.com/")!
    public var path: String { "icons/\(guildID)/\(iconHash).png" }
    
    public init (guildID: Snowflake, iconHash: String) {
        self.guildID = guildID
        self.iconHash = iconHash
    }
    
    public func decodeResponse(from data: Data) throws -> Response {
        guard let image = Response(data: data) else {
            throw NSError() // TODO make a real error type
        }
        
        return image
    }
}
