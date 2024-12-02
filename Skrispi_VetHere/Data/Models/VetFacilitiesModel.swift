//
//  VaccineSchedule.swift
//  VetHereiOSSkripsi
//
//  Created by Christian Gunawan on 31/10/24.
//

import SwiftUI

struct VetFacilityModel: Identifiable, Codable {
    let id: UUID
    let facilityID: UUID
    let createdAt: Date
    let updatedAt: Date
}
