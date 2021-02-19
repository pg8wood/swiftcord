//
//  Channel.swift
//  DiscordVoice
//
//  Created by Patrick Gatewood on 2/10/21.
//

import Foundation
import Combine

public enum ChannelType: Int, Codable {
    case guildText = 0
    case directMessage
    case guildVoice
    case groupDirectMessage
    case guildCategory
    case guildNews
    case guildStore
}

public class Channel: ObservableObject, Hashable, Equatable, Identifiable {
    public static func == (lhs: Channel, rhs: Channel) -> Bool {
        lhs.id == rhs.id
    }
 
    public static var uncategorizedChannelID: Snowflake = "Uncategorized"
    public static func makeUncategorizedCategory() -> Channel {
        Channel(from: ChannelPayload(
                    id: uncategorizedChannelID,
                    type: .guildCategory,
                    guildID: nil,
                    name: uncategorizedChannelID,
                    position: -1,
                    parentID: nil))
    }

    public let id: Snowflake
    public let type: ChannelType
    public let guildID: Snowflake?
    public let name: String
    public let position: Int
    public let parentID: Snowflake?
    
    let payload: ChannelPayload
    
    public convenience init (
        id: Snowflake,
        type: ChannelType,
        guildID: Snowflake?,
        name: String?,
        position: Int?,
        parentID: Snowflake?) {
        
        let payload = ChannelPayload(
            id: id,
            type: type,
            guildID: guildID,
            name: name,
            position: position,
            parentID: parentID)
        self.init(from: payload)
    }
        
    init(from payload: ChannelPayload) {
        self.payload = payload
        self.id = payload.id
        self.type = payload.type
        self.guildID = payload.guildID
        self.name = payload.name ?? "Unknown Channel"
        self.position = payload.position ?? -1
        self.parentID = payload.parentID
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

/// NOTE: Beware putting @Published vars in ObservableObject subclasses. Unless the property
/// observer manually calls objectWillChange.send(), if you're observing this class as a `Channel`
/// object, the observer won't fire! I'm not sure if this is a bug or intentional, but nonetheless will
/// probably avoid inheritance moving forward.
/// 
/// See: https://stackoverflow.com/a/57620669
public class VoiceChannel: Channel {
    @Published public var usersInVoice: [User] = [] {
        didSet {
            super.objectWillChange.send()
        }
    }
    
    #warning("This needs to be internal!")
    public func observe(voiceStates: AnyPublisher<[VoiceState], Never>,
                 on guild: Guild) -> AnyCancellable {
        voiceStates.sink { [weak self] newVoiceStates in
            guard let self = self else { return }
            
            self.usersInVoice = newVoiceStates.filter {
                $0.channelID == self.id
            }
            .compactMap { voiceState in
                if let user = voiceState.member?.user {
                    return user
                }
                
                // Voice State Update events include members, but the Guild's initial
                // Voice States omit them for some reason
                return guild.members
                    .compactMap(\.user)
                    .first(where: { $0.id == voiceState.userID })
            }
        }
    }
}
