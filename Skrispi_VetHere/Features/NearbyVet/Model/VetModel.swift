//
//  Vet.swift
//  VetHereiOS
//
//  Created by Christian Gunawan on 22/10/24.
//

import Foundation


struct VetModel: Identifiable, Codable, Hashable {
    let id: UUID
    let detailId: UUID
    let name: String
    let description: String
    let rating: Int
    let openHour: Double
    let closeHour: Double
    let image: String
    let createdAt: Date
    let updatedAt: Date
    let range: Double
    let address: String
    
    
    init(id: UUID, detailId: UUID, name: String, description: String, rating: Int, openHour: Double, closeHour: Double, image: String, createdAt: Date, updatedAt: Date, range: Double, address: String) {
        self.id = id
        self.detailId = detailId
        self.name = name
        self.description = description
        self.rating = rating
        self.openHour = openHour
        self.closeHour = closeHour
        self.image = image
        self.createdAt = createdAt
        self.updatedAt = updatedAt
        self.range = range
        self.address = address
    }
    
    static func == (lhs: VetModel, rhs: VetModel) -> Bool {
        return lhs.id == rhs.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}


