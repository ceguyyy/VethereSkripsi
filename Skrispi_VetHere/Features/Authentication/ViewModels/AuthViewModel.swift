//
//  AuthViewModel.swift
//  Skrispi_VetHere
//
//  Created by Christian Gunawan on 06/11/24.
//

import Combine
import SwiftUI

class AuthViewModel: ObservableObject {
    @Published var username: String = ""
    @Published var password: String = ""
    @Published var role: String = "user"
    @Published var createdAt: Date = Date.now
    @Published var updatedAt: Date = Date.now
    @Published var isAuthenticated: Bool = false
    @Published var errorMessage: String?
    @Published var successMessage: String? = nil
    @Published var currentUser: UserModel?
    @Published var isLogin: Bool = true
    @Published var imageName: String = ""
    @Published var firstName: String = ""
    @Published var lastName: String = ""
    @Published var name: String = "" {
        didSet {
            let components = name.split(separator: " ", maxSplits: 1).map { String($0) }
            firstName = components.first ?? ""
            lastName = components.count > 1 ? components.last ?? "" : ""
        }
    }
    
    private var cancellables = Set<AnyCancellable>()
    
    static var mock: AuthViewModel {
            let vm = AuthViewModel()
        vm.currentUser = UserModel(userID: UUID(), username: "Christian", firstName: "Christian", lastName: "Gunawan", password: "Christian", role: "User", imageName: "https://media.licdn.com/dms/image/v2/D5603AQHvobv7mQ-cow/profile-displayphoto-shrink_200_200/profile-displayphoto-shrink_200_200/0/1704765668714?e=2147483647&v=beta&tz=mBPL4u4a5YeR89d4ISbGIcXdoaK52OkfQq1gMLfR76Q", createdAt: Date(),updatedAt: Date())
                                
            
            return vm
        }
    
    func login() {
        AuthService.shared.login(username: username, password: password)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    self.errorMessage = error.localizedDescription
                    print("Error: \(error)")
                }
            }, receiveValue: { response in
                if let data = response["data"] as? [String: Any],
                   let accessToken = data["access_token"] as? String {
                    print("Received Access Token: \(accessToken)")
                    TokenManager.shared.token = accessToken
                    self.isAuthenticated = true
                    self.successMessage = "Login successful"
                    self.currentUser = UserModel(userID: UUID(), username: self.username, firstName: self.firstName, lastName: self.lastName, password: self.password, role: self.role, imageName: self.imageName, createdAt: self.createdAt, updatedAt: self.updatedAt)
                    
                } else {
                    self.errorMessage = "Failed to parse response"
                }
            })
            .store(in: &cancellables)
    }
    
    
    
    func register() {
        AuthService.shared.register(username: username, password: password, firstName: firstName, lastname: lastName)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    self.errorMessage = error.localizedDescription
                }
            }, receiveValue: { response in
                if let data = response["data"] as? [String: Any],
                   let accessToken = data["access_token"] as? String {
                    self.successMessage = "User created successfully"
                    self.errorMessage = nil
                    TokenManager.shared.token = accessToken
                    self.isAuthenticated = false
                } else {
                    self.errorMessage = "Failed to parse response"
                }
            })
            .store(in: &cancellables)
    }

    
    func logout() {
        TokenManager.shared.logout()
        isAuthenticated = false
        currentUser = nil
        errorMessage = nil
        successMessage = nil
    }
    
    func clearFields() {
        username = ""
        password = ""
        firstName = ""
    }
}
