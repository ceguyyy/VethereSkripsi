//
//  AppointmentModel.swift
//  Skrispi_VetHere
//
//  Created by Christian Gunawan on 05/11/24.
//

import SwiftUI

class AppointmentModel: Identifiable, Codable, Hashable {
    let AppointmentId: UUID
    let VetId: UUID
    let DoctorId: UUID
    let UserId: UUID
    let PetId: UUID
    var AppointmentNote: String
    var AppointmentDate: Date
    var AppointmentTime: Date

    init(AppointmentId: UUID, VetId: UUID, DoctorId: UUID, UserId: UUID, PetId: UUID, AppointmentNote: String, AppointmentDate: Date, AppointmentTime: Date) {
        self.AppointmentId = AppointmentId
        self.VetId = VetId
        self.DoctorId = DoctorId
        self.UserId = UserId
        self.PetId = PetId
        self.AppointmentNote = AppointmentNote
        self.AppointmentDate = AppointmentDate
        self.AppointmentTime = AppointmentTime
    }
    
    // Conformance to Hashable
    static func == (lhs: AppointmentModel, rhs: AppointmentModel) -> Bool {
        return lhs.id == rhs.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
