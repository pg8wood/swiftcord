//
//  GetUserAvatarRequest.swift
//  DiscordVoice
//
//  Created by Patrick Gatewood on 2/7/21.
//

#if os(iOS)
import UIKit
#elseif os(macOS)
import AppKit
#endif

public struct GetUserAvatarRequest: APIRequest {
    #if os(iOS)
    public typealias Response = UIImage
    #elseif os(macOS)
    public typealias Response = NSImage
    #endif

    public let userID: Snowflake
    public let avatar: String
    
    public let baseURL = URL(string: "https://cdn.discordapp.com/")!
    public var path: String { "avatars/\(userID)/\(avatar).png" }
    
    public init(userID: Snowflake, avatar: String) {
        self.userID = userID
        self.avatar = avatar
    }
    
    public func decodeResponse(from data: Data) throws -> Response {
        guard let image = Response(data: data) else {
            throw NSError() // TODO make a real error type
        }

        return image
    }
}
