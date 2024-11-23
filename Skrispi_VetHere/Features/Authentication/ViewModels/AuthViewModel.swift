//
//  AuthViewModel.swift
//  Skrispi_VetHere
//
//  Created by Christian Gunawan on 06/11/24.
//

import Combine
import SwiftUI

class AuthViewModel: ObservableObject {
    @Published var username = ""
  
    @Published var password = ""
    @Published var role = "user"
    @Published var createdAt = Date.now
    @Published var updatedAt = Date.now
    @Published var email = ""
    @Published var isAuthenticated = false
    @Published var errorMessage: String?
    @Published var successMessage: String? = nil
    @Published var currentUser: UserModel?
    @Published var isLogin = true
    @Published var imageName = ""
    @Published var firstName = ""
    @Published var lastName = ""
    @Published var name = "" {
        didSet {
            let components = name.split(separator: " ", maxSplits: 1).map { String($0) }
            firstName = components.first ?? ""
            lastName = components.count > 1 ? components.last ?? "" : ""
        }
    }
    
    private var cancellables = Set<AnyCancellable>()
    
    static var mock: AuthViewModel {
        let vm = AuthViewModel()
        vm.currentUser = UserModel(id: UUID(), email: "Christian@gmail.com", username: "Christian", lastName: "Gunawan", firstName: "Christian", password: "Christian", role: "User", createdAt: Date(), updatedAt: Date(),imageName: "https://media.licdn.com/dms/image/v2/D5603AQHvobv7mQ-cow/profile-displayphoto-shrink_200_200/profile-displayphoto-shrink_200_200/0/1704765668714?e=2147483647&v=beta&t=mBPL4u4a5YeR89d4ISbGIcXdoaK52OkfQq1gMLfR76Q")
                                   
        
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
            }, receiveValue: { token in
                print("Received Token: \(token)")
                TokenManager.shared.token = token
                self.isAuthenticated = true
                self.successMessage = "Valid"
                self.currentUser = UserModel(id: UUID(), email: self.email, username: self.username, lastName: self.lastName, firstName: self.firstName, password: self.password, role: self.role, createdAt: self.createdAt, updatedAt: self.updatedAt, imageName: self.imageName)
            })
        
            .store(in: &cancellables)
    }
    
    
    func signup() {
        AuthService.shared.signup(username: username, password: password, firstName: firstName, email: email, role: role, createdAt: createdAt, updatedAt: updatedAt, lastname: lastName)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    self.errorMessage = error.localizedDescription
                }
            }, receiveValue: { token in
                self.successMessage = "User created"
                self.errorMessage = nil
                TokenManager.shared.token = token
                self.isAuthenticated = false
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
        email = ""
    }
}
