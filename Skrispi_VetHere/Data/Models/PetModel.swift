//
//  PetModel.swift
//  VetHereiOSSkripsi
//
//  Created by Christian Gunawan on 31/10/24.
//

import SwiftUI
import Combine

struct PetModel: Identifiable, Decodable, Hashable {
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
}
