//
//  DoctorModel.swift
//  VetHereiOS
//
//  Created by Christian Gunawan on 29/10/24.
//

import Foundation

struct DoctorModel: Identifiable, Codable, Hashable {
    let id: UUID
    let vetId: UUID
    let specializationId: UUID
    let name: String
    let rating: Int
    let creadtedAt: Date
    let updatedAt: Date
    let image: String
}

