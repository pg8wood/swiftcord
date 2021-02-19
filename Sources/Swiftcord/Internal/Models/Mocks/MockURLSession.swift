//
//  MockURLSession.swift
//  DiscordVoice
//
//  Created by Patrick Gatewood on 2/16/21.
//

import Combine
import Foundation

public struct MockURLSession: URLSessionProtocol {
    public var mockResult: Result<Data, URLError> = .failure(URLError(.unknown))
        
    public func apiResponse(for request: URLRequest) -> AnyPublisher<APIResponse, URLError> {
        mockResult.map {
            (data: $0, response: URLResponse(url: request.url!, mimeType: nil, expectedContentLength: 0, textEncodingName: "utf8"))
        }
        .publisher
        .eraseToAnyPublisher()
    }
    
    public func webSocketTask(with url: URL) -> URLSessionWebSocketTask {
        fatalError("Not implemented yet")
    }
}
