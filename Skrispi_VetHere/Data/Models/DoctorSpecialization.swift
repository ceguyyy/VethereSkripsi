//
//  DoctorSpecialization.swift
//  Skrispi_VetHere
//
//  Created by Christian Gunawan on 05/11/24.
//

import SwiftUI

class DoctorSpecialization: Identifiable, Codable, Hashable {
    let id: UUID
    let name: String
    
    init(id: UUID, name: String) {
        self.id = id
        self.name = name
    }
    
    static func == (lhs: DoctorSpecialization, rhs: DoctorSpecialization) -> Bool {
        return lhs.id == rhs.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
}
