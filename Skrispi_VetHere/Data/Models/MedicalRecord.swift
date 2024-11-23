//
//  MedicalHistoryModel.swift
//  VetHereiOSSkripsi
//
//  Created by Christian Gunawan on 31/10/24.
//

import SwiftUI

struct MedicalRecordModel: Identifiable, Codable, Hashable {
    let id: UUID
    let details: String
    let diagnosis: String
    let treatment: String
    let createdAt: Date
    let deletedAt: Date?
}
