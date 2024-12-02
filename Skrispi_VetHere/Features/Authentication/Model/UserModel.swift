//
//  UserModel.swift
//  VetHereiOSSkripsi
//
//  Created by Christian Gunawan on 31/10/24.
//

import Foundation

class UserModel: Identifiable {
    let Userid: UUID
    let username: String
    let first_Name: String
    let last_Name: String
    let password: String
    let role: String
    let createdAt: Date
    let updatedAt: Date
    let imageName: String
    
    init(Userid: UUID, username: String, first_Name: String, last_Name: String, password: String, role: String, createdAt: Date, updatedAt: Date, imageName: String) {
        self.Userid = Userid
        self.username = username
        self.first_Name = first_Name
        self.last_Name = last_Name
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
