//
//  GatewayError.swift
//  
//
//  Created by Patrick Gatewood on 2/19/21.
//

import Foundation

public enum GatewayError: LocalizedError {
    case invalidRequest
    case initialConnectionFailed
    case decodingFailed
    case webSocket(Error)
    case http(APIError)
    
    public var errorDescription: String? {
        switch self {
        case .invalidRequest:
            return "Invalid request"
        case .initialConnectionFailed:
            return "Connecting to Discord failed"
        case .decodingFailed:
            return "Failed to decode response from Discord"
        case .webSocket(let error):
            return "Web socket error: \(error.localizedDescription)"
        case .http(let apiError):
            return apiError.localizedDescription
        }
    }
}
