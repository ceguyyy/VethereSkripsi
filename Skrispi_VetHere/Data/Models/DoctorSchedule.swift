//
//  DoctorSchedule.swift
//  Skrispi_VetHere
//
//  Created by Christian Gunawan on 05/11/24.
//

import SwiftUI


struct DoctorScheduleModel: Identifiable {
    let id: UUID
    let doctorId: UUID
    let date: Date
    let endTime: Date
    let startTime: Date
}
