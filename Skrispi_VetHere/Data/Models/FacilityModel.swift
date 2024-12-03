//
//  FacilityModel.swift
//  Skrispi_VetHere
//
//  Created by Christian Gunawan on 03/12/24.
//

import SwiftUI

class FacilityModel: Identifiable, Codable, Hashable {
    let id: UUID
    let facilityName: String
    
    init(id: UUID, facilityName: String) {
        self.id = id
        self.facilityName = facilityName
    }
    
    static func == (lhs: FacilityModel, rhs: FacilityModel) -> Bool {
        return lhs.id == rhs.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
}
