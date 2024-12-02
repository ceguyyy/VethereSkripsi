//
//  APIError.swift
//  Skrispi_VetHere
//
//  Created by Christian Gunawan on 19/11/24.
//

import Foundation

enum APIError: LocalizedError {
    case invalidURL
    case invalidResponse
    case decodingError
    case httpError(Int)
    case serverError
    case parsingError
    case unknown

    var errorDescription: String? {
        switch self {
        case .parsingError:
            return "Failed to parse the response."
        case .serverError:
            return "The server encountered an error."
        case .invalidURL:
            return "The provided URL is invalid."
        case .invalidResponse:
            return "The response from the server is invalid."
        case .decodingError:
            return "Failed to decode the response."
        case .httpError(let statusCode):
            return "HTTP error with status code: \(statusCode)."
        case .unknown:
            return "An unknown error occurred."
        }
    }
}
