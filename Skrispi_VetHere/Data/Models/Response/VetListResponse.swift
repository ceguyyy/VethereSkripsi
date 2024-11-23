//
//  VetListResponse.swift
//  Skrispi_VetHere
//
//  Created by Christian Gunawan on 18/11/24.
//

import Foundation

struct VetListResponse: Codable {
    struct VetData: Codable {
        struct VetDetails: Codable {
            let vet_id: String
            let vet_name: String
            let vet_description: String
            let vet_rating: Int
            let vet_open_hour: String
            let vet_close_hour: String
            let vet_image: String
        }
        
        let vet: VetDetails
        let vet_distance: Double
    }
    
    let meta: Meta
    let data: [VetData]
    
    struct Meta: Codable {
        let success: Bool
        let message: String
    }
}
