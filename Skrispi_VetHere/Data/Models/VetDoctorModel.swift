//
//  DoctorModel.swift
//  VetHereiOS
//
//  Created by Christian Gunawan on 29/10/24.
//

import Foundation

class DoctorModel: Identifiable, Codable, Hashable {
    let DoctorId: UUID
    let VetId: UUID
    let SpecializationId: UUID
    let DoctorName: String
    let DoctorRating: Int
    let creadtedAt: Date
    let updatedAt: Date
    let image: String
    
    init(DoctorId: UUID, VetId: UUID, SpecializationId: UUID, DoctorName: String, DoctorRating: Int, creadtedAt: Date, updatedAt: Date, image: String) {
        self.DoctorId = DoctorId
        self.VetId = VetId
        self.SpecializationId = SpecializationId
        self.DoctorName = DoctorName
        self.DoctorRating = DoctorRating
        self.creadtedAt = creadtedAt
        self.updatedAt = updatedAt
        self.image = image
    }
    
    static func == (lhs: DoctorModel, rhs: DoctorModel) -> Bool {
        return lhs.id == rhs.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    
}

