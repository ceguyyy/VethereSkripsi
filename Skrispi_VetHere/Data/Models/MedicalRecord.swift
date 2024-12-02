//
//  MedicalHistoryModel.swift
//  VetHereiOSSkripsi
//
//  Created by Christian Gunawan on 31/10/24.
//

import SwiftUI

class MedicalRecordModel: Identifiable, Codable, Hashable {
    let id: UUID
    let details: String
    let diagnosis: String
    let treatment: String
    let createdAt: Date
    let deletedAt: Date?
    
    init(id: UUID, details: String, diagnosis: String, treatment: String, createdAt: Date, deletedAt: Date?) {
        self.id = id
        self.details = details
        self.diagnosis = diagnosis
        self.treatment = treatment
        self.createdAt = createdAt
        self.deletedAt = deletedAt
    }
    
    static func == (lhs: MedicalRecordModel, rhs: MedicalRecordModel) -> Bool {
        return lhs.id == rhs.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    
}
