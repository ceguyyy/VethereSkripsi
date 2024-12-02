//
//  PetTypeModel.swift
//  Skrispi_VetHere
//
//  Created by Christian Gunawan on 05/11/24.
//

import SwiftUI

class PetTypeModel: Identifiable {
    let id: Int
    let name: String
    let createdAt: Date
    let updatedAt: Date
    
    init(id: Int, name: String, createdAt: Date, updatedAt: Date) {
        self.id = id
        self.name = name
        self.createdAt = createdAt
        self.updatedAt = updatedAt
    }
    
    static func == (lhs: PetTypeModel, rhs: PetTypeModel) -> Bool {
        return lhs.id == rhs.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
