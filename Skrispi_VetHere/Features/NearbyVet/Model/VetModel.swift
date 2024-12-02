//
//  Vet.swift
//  VetHereiOS
//
//  Created by Christian Gunawan on 22/10/24.
//

import Foundation


struct VetModel: Identifiable, Codable, Hashable {
    let id: UUID
    let detailID: UUID
    let name: String
    let description: String
    let rating: Int
    let openHour: Double
    let closeHour: Double
    let image: String
    let range: Double
    let address: String
    let createdAt: Date
    let updatedAt: Date

    
    init(id: UUID, detailID: UUID, name: String, description: String, rating: Int, openHour: Double, closeHour: Double, image: String, range: Double, address: String, createdAt: Date, updatedAt: Date) {
        self.id = id
        self.detailID = detailID
        self.name = name
        self.description = description
        self.rating = rating
        self.openHour = openHour
        self.closeHour = closeHour
        self.image = image
        self.range = range
        self.address = address
        self.createdAt = createdAt
        self.updatedAt = updatedAt
    }
    
    static func == (lhs: VetModel, rhs: VetModel) -> Bool {
        return lhs.id == rhs.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}


