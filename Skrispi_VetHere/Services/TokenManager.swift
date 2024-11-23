//
//  TokenManager.swift
//  Skrispi_VetHere
//
//  Created by Christian Gunawan on 06/11/24.
//

import Foundation
import Security

class TokenManager {
    static let shared = TokenManager()

    var token: String? {
        get { return getToken() }
        set { newValue == nil ? deleteToken() : saveToken(newValue!) }
    }

    func isAuthenticated() -> Bool {
        return token != nil
    }

    func logout() {
        token = nil
    }

    private func saveToken(_ token: String) {
        guard let data = token.data(using: .utf8) else { return }
        
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: "jwtToken",
            kSecValueData as String: data
        ]
        
        SecItemDelete(query as CFDictionary)
        SecItemAdd(query as CFDictionary, nil)
    }

    private func getToken() -> String? {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: "jwtToken",
            kSecReturnData as String: kCFBooleanTrue!,
            kSecMatchLimit as String: kSecMatchLimitOne
        ]

        var item: AnyObject?
        SecItemCopyMatching(query as CFDictionary, &item)
        
        guard let data = item as? Data else { return nil }
        return String(data: data, encoding: .utf8)
    }

    private func deleteToken() {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: "jwtToken"
        ]
        
        SecItemDelete(query as CFDictionary)
    }
}
