//
//  VetdetailModel.swift
//  Skrispi_VetHere
//
//  Created by Christian Gunawan on 05/11/24.
//

import SwiftUI


struct VetDetailModel: Identifiable, Codable, Hashable {
    let id: UUID
    let scheduleId: UUID
    let phoneNumber: String
    let latitude: Double?
    let longitude: Double?
    let createdAt: Date
    let updatedAt: Date
}
