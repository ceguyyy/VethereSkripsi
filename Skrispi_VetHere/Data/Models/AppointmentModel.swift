//
//  AppointmentModel.swift
//  Skrispi_VetHere
//
//  Created by Christian Gunawan on 05/11/24.
//

import SwiftUI

struct AppointmentModel: Identifiable, Codable, Hashable {
    let id: UUID
    let vetId: UUID
    let doctorId: UUID
    let userId: UUID
    let petId: UUID
    let notes: String
    let date: Date
    let time: Date
}
