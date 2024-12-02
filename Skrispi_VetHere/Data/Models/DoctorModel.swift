//
//  DoctorModel.swift
//  VetHereiOS
//
//  Created by Christian Gunawan on 29/10/24.
//

import Foundation

class DoctorModel: Identifiable, Codable, Hashable {
    let doctorId: UUID
    let vetId: UUID
    let specializationId: UUID
    let doctorName: String
    let doctorRating: Int
    let doctorImage: String
    let createdAt: Date
    let updatedAt: Date
    
    init(doctorId: UUID, vetId: UUID, specializationId: UUID, doctorName: String, doctorRating: Int, doctorImage: String, createdAt: Date, updatedAt: Date) {
        self.doctorId = doctorId
        self.vetId = vetId
        self.specializationId = specializationId
        self.doctorName = doctorName
        self.doctorRating = doctorRating
        self.doctorImage = doctorImage
        self.createdAt = createdAt
        self.updatedAt = updatedAt
    }
    
    static func == (lhs: DoctorModel, rhs: DoctorModel) -> Bool {
        return lhs.id == rhs.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    
}

