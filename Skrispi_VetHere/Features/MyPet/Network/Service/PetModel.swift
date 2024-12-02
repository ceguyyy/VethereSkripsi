//
//  PetModel.swift
//  VetHereiOSSkripsi
//
//  Created by Christian Gunawan on 31/10/24.
//

import SwiftUI
import Combine

class PetModel: Identifiable, Decodable, Hashable {
    let id: UUID
    let userID: UUID
    let petTypeID: UUID
    let medicalRecordID: UUID
    let breedID: UUID
    let image: String
    let name: String
    let color: String
    let dob: Date
    let weight: Double
    let createdAt: Date
    let updatedAt: Date
    
    init(id: UUID, userID: UUID, petTypeID: UUID, medicalRecordID: UUID, breedID: UUID, image: String, name: String, color: String, dob: Date, weight: Double, createdAt: Date, updatedAt: Date) {
        self.id = id
        self.userID = userID
        self.petTypeID = petTypeID
        self.medicalRecordID = medicalRecordID
        self.breedID = breedID
        self.image = image
        self.name = name
        self.color = color
        self.dob = dob
        self.weight = weight
        self.createdAt = createdAt
        self.updatedAt = updatedAt
    }
    
    static func == (lhs: PetModel, rhs: PetModel) -> Bool {
        return lhs.id == rhs.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    
}
