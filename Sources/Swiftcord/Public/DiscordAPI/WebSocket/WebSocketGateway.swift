//
//  WebSocketGateway.swift
//  DiscordVoice
//
//  Created by Patrick Gatewood on 11/25/20.
//

import Foundation
import Combine

public protocol WebSocketGateway {
    var discordAPI: APIClient { get }
    var eventPublisher: AnyPublisher<Event, Never> { get }
    
    func connect() -> AnyPublisher<ReadyPayload, GatewayError>
    func send(command: Command)
}
