//
//  Guild.swift
//  DiscordVoice
//
//  Created by Patrick Gatewood on 2/8/21.
//

import Combine

public class Guild: ObservableObject, Encodable, Hashable, Equatable, Identifiable {
    public static func == (lhs: Guild, rhs: Guild) -> Bool {
        lhs.id == rhs.id
    }
    
    public let id: Snowflake
    public let name: String
    public var iconHash: String?
    @Published public var voiceStates: [VoiceState]
    //    @Published var icon: UIImage? // TODO
    @Published public var members: [GuildMember]
    @Published public var channelsByCategory: [Channel: [Channel]]
    
    public var voiceChannels: [VoiceChannel] {
        channelsByCategory.values
            .flatMap {
                $0.compactMap { channel in
                    channel as? VoiceChannel
                }
            }
    }
    
    private let payload: GuildPayload
    
    public convenience init(
        id: Snowflake,
        name: String,
        icon: String?,
        voiceStates: [VoiceState],
        members: [GuildMember],
        channels: [Channel]) {
        
        let payload = GuildPayload(
            id: id,
            name: name,
            icon: icon,
            voiceStates: voiceStates,
            members: members,
            channels: channels.map { $0.payload })
        self.init(from: payload)
    }
    
    init(from payload: GuildPayload) {
        func organizeChannelsByCategory(_ channels: [ChannelPayload]) -> [Channel: [Channel]] {
            let typedChannels: [Channel] = channels.map {
                switch $0.type {
                case .guildVoice:
                    return VoiceChannel(from: $0)
                default:
                    return Channel(from: $0)
                }
            }
            let allChannels = Set(typedChannels)
            var categories = Set(allChannels.filter { $0.type == .guildCategory })
            
            let uncategorized = Channel.makeUncategorizedCategory()
            categories.insert(uncategorized)
            
            let nonCategoryChannels = allChannels.subtracting(categories)
            
            return Dictionary(
                grouping: nonCategoryChannels,
                by: { $0.parentID ?? Channel.uncategorizedChannelID })
                .compactMapKeys { channelID in
                    categories.first(where: { $0.id == channelID }) ?? uncategorized
                }
        }
        
        self.payload = payload
        id = payload.id
        name = payload.name
        iconHash = payload.icon
        voiceStates = payload.voiceStates
        members = payload.members
        channelsByCategory = organizeChannelsByCategory(payload.channels)
    }
    
    // MARK: Encodable
    
    public func encode(to encoder: Encoder) throws {
        try payload.encode(to: encoder)
    }
    
    // MARK: Hashable
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    // TODO: can we use "assign" to subscribe guilds to their state updates instead of using sink?
    
    #warning("This needs to be internal!")
    public func didReceiveVoiceStateUpdate(_ voiceState: VoiceState) {
        guard let index = voiceStates.firstIndex(where: { $0.userID == voiceState.userID }) else {
            voiceStates.append(voiceState)
            return
        }
        
        voiceStates[index] = voiceState
    }
}

private extension Array where Element: Hashable {
    func removingDuplicates() -> [Element] {
        var addedDict = [Element: Bool]()
        
        return filter {
            addedDict.updateValue(true, forKey: $0) == nil
        }
    }
    
    mutating func removeDuplicates() {
        self = self.removingDuplicates()
    }
}

private extension Dictionary {
    func compactMapKeys<Transformed>(_ transform: (Key) throws -> Transformed?) rethrows -> [Transformed: Value] {
        .init(
            uniqueKeysWithValues: try compactMap { key, value in
                try transform(key).map { ($0, value) }
            }
        )
    }
}
