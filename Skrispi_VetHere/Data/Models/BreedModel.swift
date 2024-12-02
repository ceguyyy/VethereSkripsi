//
//  BreedModel.swift
//  Skrispi_VetHere
//
//  Created by Christian Gunawan on 05/11/24.
//

import SwiftUI

class BreedModel: Identifiable, Codable, Hashable {
    let breedId: UUID
    var breedName: String
    var createdAt: Date
    var updatedAt: Date

    init(breedId: UUID, breedName: String, createdAt: Date, updatedAt: Date) {
        self.breedId = breedId
        self.breedName = breedName
        self.createdAt = createdAt
        self.updatedAt = updatedAt
    }
    
    static func == (lhs: BreedModel, rhs: BreedModel) -> Bool {
        return lhs.id == rhs.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
