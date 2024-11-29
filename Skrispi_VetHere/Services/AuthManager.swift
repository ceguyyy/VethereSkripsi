//
//  AuthManager.swift
//  Skrispi_VetHere
//
//  Created by Christian Gunawan on 05/11/24.
//

import Foundation
import Combine

import Foundation
import Combine

class AuthService {
    static let shared = AuthService()
    private let baseURL = "http://localhost:8000"
    private var cancellables = Set<AnyCancellable>()
    
    enum AuthError: LocalizedError {
        case invalidCredentials
        case usernameAlreadyTaken
        case serverError(String)
        case unknownError
        
        var errorDescription: String? {
            switch self {
            case .invalidCredentials:
                return "Invalid username or password."
            case .usernameAlreadyTaken:
                return "Username is already taken."
            case .serverError(let message):
                return message
            case .unknownError:
                return "An unknown error occurred."
            }
        }
    }

    func login(username: String, password: String) -> AnyPublisher<[String: Any], Error> {
        let url = URL(string: "\(baseURL)/auth/login")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let body: [String: String] = ["username": username, "password": password]
        request.httpBody = try? JSONSerialization.data(withJSONObject: body)
        
        return URLSession.shared.dataTaskPublisher(for: request)
            .tryMap { data, response in
                guard let httpResponse = response as? HTTPURLResponse else {
                    throw URLError(.badServerResponse)
                }
                if httpResponse.statusCode == 200 {
                    guard let json = try? JSONSerialization.jsonObject(with: data) as? [String: Any] else {
                        throw AuthError.unknownError
                    }
                    return json
                } else {
                    let errorResponse = try? JSONSerialization.jsonObject(with: data) as? [String: Any]
                    if let errorMessage = errorResponse?["error"] as? String {
                        throw AuthError.serverError(errorMessage)
                    } else {
                        throw AuthError.unknownError
                    }
                }
            }
            .eraseToAnyPublisher()
    }
    
    func signup(username: String, password: String, firstName: String, email: String, role: String = "user", createdAt: Date = Date(), updatedAt: Date = Date(), lastname: String) -> AnyPublisher<[String: Any], Error> {
        let url = URL(string: "\(baseURL)/auth/register")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let body: [String: Any] = [
            "username": username,
            "lastname" : lastname,
            "password": password,
            "first_name": firstName,
            "email": email,
            "role": role,
            "createdAt": ISO8601DateFormatter().string(from: createdAt),
            "updatedAt": ISO8601DateFormatter().string(from: updatedAt)
        ]
        
        request.httpBody = try? JSONSerialization.data(withJSONObject: body)
        
        return URLSession.shared.dataTaskPublisher(for: request)
            .tryMap { data, response in
                guard let httpResponse = response as? HTTPURLResponse else {
                    throw URLError(.badServerResponse)
                }
                if httpResponse.statusCode == 201 {
                    guard let json = try? JSONSerialization.jsonObject(with: data) as? [String: Any] else {
                        throw AuthError.unknownError
                    }
                    return json
                } else {
                    let errorResponse = try? JSONSerialization.jsonObject(with: data) as? [String: Any]
                    if let errorMessage = errorResponse?["error"] as? String {
                        throw AuthError.serverError(errorMessage)
                    } else {
                        throw AuthError.unknownError
                    }
                }
            }
            .eraseToAnyPublisher()
    }
}
