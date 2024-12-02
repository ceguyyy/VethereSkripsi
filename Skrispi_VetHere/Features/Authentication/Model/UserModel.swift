//
//  UserModel.swift
//  VetHereiOSSkripsi
//
//  Created by Christian Gunawan on 31/10/24.
//

import Foundation

class UserModel: Identifiable {
    let userID: UUID
    let username: String
    let firstName: String
    let lastName: String
    let password: String
    let role: String
    let createdAt: Date
    let updatedAt: Date
    let imageName: String
    
    init(userID: UUID, username: String, firstName: String, lastName: String, password: String, role: String, imageName: String, createdAt: Date, updatedAt: Date) {
        self.userID = userID
        self.username = username
        self.firstName = firstName
        self.lastName = lastName
        self.password = password
        self.role = role
        self.createdAt = createdAt
        self.updatedAt = updatedAt
        self.imageName = imageName
    }
    
    static func == (lhs: UserModel, rhs: UserModel) -> Bool {
        return lhs.id == rhs.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
}
