//
//  DiscordAPI.swift
//  DiscordVoice
//
//  Created by Patrick Gatewood on 11/24/20.
//

import Foundation
import Combine

public class DiscordAPI: APIClient {
    public let session: URLSessionProtocol
    
    public init(session: URLSessionProtocol) {
        self.session = session
    }
    
    public func get<T: APIRequest>(_ request: T) -> AnyPublisher<T.Response, APIError> {
        let url = request.baseURL.appendingPathComponent(request.path)
        var urlRequest = URLRequest(url: url)
        
        request.headers.forEach {
            urlRequest.setValue($0.value, forHTTPHeaderField: $0.key)
        }
        
        return session.apiResponse(for: urlRequest)
            .map(\.data)
            .tryMap(request.decodeResponse)
            .mapError { error -> APIError in
                switch error {
                case is DecodingError:
                    return .decodingFailed
                case let urlError as URLError:
                    return .sessionFailed(urlError)
                default:
                    return .unknown(error)
                }
            }
            .eraseToAnyPublisher()
    }
}

/// Credit to this fantastic answer: https://stackoverflow.com/a/61627636
public protocol URLSessionProtocol {
    typealias APIResponse = URLSession.DataTaskPublisher.Output
    
    func apiResponse(for request: URLRequest) -> AnyPublisher<APIResponse, URLError>
    func webSocketTask(with url: URL) -> URLSessionWebSocketTask
}

extension URLSession: URLSessionProtocol {
    public func apiResponse(for request: URLRequest) -> AnyPublisher<APIResponse, URLError> {
        return dataTaskPublisher(for: request).eraseToAnyPublisher()
    }
}
