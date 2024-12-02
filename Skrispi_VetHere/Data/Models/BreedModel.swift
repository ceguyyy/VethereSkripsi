//
//  BreedModel.swift
//  Skrispi_VetHere
//
//  Created by Christian Gunawan on 05/11/24.
//

import SwiftUI

class BreedModel: Identifiable, Codable, Hashable {
    let breedID: UUID
    var breedName: String
    var createdAt: Date
    var updatedAt: Date

    init(breedID: UUID, breedName: String, createdAt: Date, updatedAt: Date) {
        self.breedID = breedID
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
