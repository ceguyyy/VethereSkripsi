//
//  AuthManager.swift
//  Skrispi_VetHere
//
//  Created by Christian Gunawan on 05/11/24.
//

import Foundation
import Combine

class AuthService {
    static let shared = AuthService()
    private let baseURL = "https://alive-maple-feather.glitch.me"
    
    func login(username: String, password: String) -> AnyPublisher<String, Error> {
        let url = URL(string: "\(baseURL)/login")!
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
                    let json = try JSONSerialization.jsonObject(with: data) as? [String: Any]
                    return json?["token"] as? String ?? ""
                } else {
                    let errorResponse = try? JSONSerialization.jsonObject(with: data) as? [String: Any]
                    print("Error response: \(String(describing: errorResponse))")
                    if let errorMessage = errorResponse?["error"] as? String {
                        throw URLError(.badServerResponse, userInfo: [NSLocalizedDescriptionKey: errorMessage])
                    } else {
                        throw URLError(.badServerResponse, userInfo: [NSLocalizedDescriptionKey: "Unknown server error."])
                    }
                }
            }
            .eraseToAnyPublisher()
    }

    
    
    func signup(username: String, password: String, firstName: String, email: String, role: String = "user", createdAt: Date = Date(), updatedAt: Date = Date(), lastname: String) -> AnyPublisher<String, Error> {
        let url = URL(string: "\(baseURL)/signup")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let body: [String: Any] = [
            "username": username,
            "lastname" : lastname,
            "password": password,
            "firstName": firstName,
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
                    let json = try JSONSerialization.jsonObject(with: data) as? [String: Any]
                    if let message = json?["message"] as? String {
                        print("Server response message: \(message)")
                        return json?["token"] as? String ?? ""
                    }
                    throw URLError(.badServerResponse)
                } else {
                    let errorResponse = try? JSONSerialization.jsonObject(with: data) as? [String: Any]
                    print("Error response: \(String(describing: errorResponse))")
                    if let errorMessage = errorResponse?["error"] as? String {
                        throw URLError(.badServerResponse, userInfo: [NSLocalizedDescriptionKey: errorMessage])
                    }
                    
                    throw URLError(.badServerResponse)
                }
            }
            .eraseToAnyPublisher()
    }
}
