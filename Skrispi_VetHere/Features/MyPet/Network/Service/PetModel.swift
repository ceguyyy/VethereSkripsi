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
    let userId: UUID
    let petTypeId: UUID
    let medicalRecordId: UUID
    let breedId: UUID
    let image: String
    let name: String
    let color: String
    let dob: Date
    let createdAt: Date
    let updatedAt: Date
    let weight: Double
    
    init(id: UUID, userId: UUID, petTypeId: UUID, medicalRecordId: UUID, breedId: UUID, image: String, name: String, color: String, dob: Date, createdAt: Date, updatedAt: Date, weight: Double) {
        self.id = id
        self.userId = userId
        self.petTypeId = petTypeId
        self.medicalRecordId = medicalRecordId
        self.breedId = breedId
        self.image = image
        self.name = name
        self.color = color
        self.dob = dob
        self.createdAt = createdAt
        self.updatedAt = updatedAt
        self.weight = weight
    }
    
    static func == (lhs: PetModel, rhs: PetModel) -> Bool {
        return lhs.id == rhs.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    
}
