//
//  UserModel.swift
//  VetHereiOSSkripsi
//
//  Created by Christian Gunawan on 31/10/24.
//

import Foundation

struct UserModel: Identifiable {
    let id: UUID
    let email: String
    let username: String
    let lastName: String
    let firstName: String
    let password: String
    let role: String
    let createdAt: Date
    let updatedAt: Date
    let imageName: String
}
