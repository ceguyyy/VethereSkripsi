//
//  AuthError.swift
//  Skrispi_VetHere
//
//  Created by Christian Gunawan on 01/12/24.
//


import Foundation
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
