//
//  VetdetailModel.swift
//  Skrispi_VetHere
//
//  Created by Christian Gunawan on 05/11/24.
//

import SwiftUI




class VetDetailModel: Identifiable, Codable, Hashable {
    var id: UUID
    var scheduleID: UUID
    var phoneNumber: String
    var latitude: Double
    var longitude: Double
    var createdAt: Date
    var updatedAt: Date
    var doctors: [DoctorModel]
    var facilities: [FacilityModel]
    
    init(id: UUID, scheduleID: UUID, phoneNumber: String, latitude: Double, longitude: Double, createdAt: Date, updatedAt: Date, doctors: [DoctorModel], facilities: [FacilityModel]) {
        self.id = id
        self.scheduleID = scheduleID
        self.phoneNumber = phoneNumber
        self.latitude = latitude
        self.longitude = longitude
        self.createdAt = createdAt
        self.updatedAt = updatedAt
        self.doctors = doctors
        self.facilities = facilities
    }
    
    static func == (lhs: VetDetailModel, rhs: VetDetailModel) -> Bool {
        return lhs.id == rhs.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
