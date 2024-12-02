//
//  AppointmentModel.swift
//  Skrispi_VetHere
//
//  Created by Christian Gunawan on 05/11/24.
//

import SwiftUI

class AppointmentModel: Identifiable, Codable, Hashable {
    let appointmentID: UUID
    let vetID: UUID
    let doctorID: UUID
    let userID: UUID
    let petID: UUID
    var appointmentNote: String
    var appointmentDate: Date
    var appointmentTime: Date

    init(appointmentID: UUID, vetID: UUID, doctorID: UUID, userID: UUID, petID: UUID, appointmentNote: String, appointmentDate: Date, appointmentTime: Date) {
        self.appointmentID = appointmentID
        self.vetID = vetID
        self.doctorID = doctorID
        self.userID = userID
        self.petID = petID
        self.appointmentNote = appointmentNote
        self.appointmentDate = appointmentDate
        self.appointmentTime = appointmentTime
    }
    
    static func == (lhs: AppointmentModel, rhs: AppointmentModel) -> Bool {
        return lhs.id == rhs.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
