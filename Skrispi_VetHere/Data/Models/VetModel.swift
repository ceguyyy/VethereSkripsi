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
}


