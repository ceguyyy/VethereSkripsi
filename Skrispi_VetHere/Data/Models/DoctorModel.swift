//
//  DoctorModel.swift
//  Skrispi_VetHere
//
//  Created by Christian Gunawan on 03/12/24.
//

import SwiftUI

class DoctorModel: Identifiable, Codable, Hashable {
    let id: UUID
    let doctorName: String
    let doctorRating: Int
    let specializationName: String
    let image: String
    
    init(id: UUID, doctorName: String, doctorRating: Int, specializationName: String, image: String) {
        self.id = id
        self.doctorName = doctorName
        self.doctorRating = doctorRating
        self.specializationName = specializationName
        self.image = image
    }
    
    static func == (lhs: DoctorModel, rhs: DoctorModel) -> Bool {
        return lhs.id == rhs.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
