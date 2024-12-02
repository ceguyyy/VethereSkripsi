//
//  VetDetailResponse.swift
//  Skrispi_VetHere
//
//  Created by Christian Gunawan on 19/11/24.
//

import Foundation

struct VetDetailResponse: Decodable {
    let data: VetDetailData
}

struct VetDetailData: Decodable {
    let vet_id: String
    let vet_detail: VetDetail
}

struct VetDetail: Decodable {
    let vet_detail_id: String
    let vet_phone_number: String
    let vet_latitude: Double
    let vet_longitude: Double
}

struct VetListDetailFromAPIResponse: Decodable {
    let data: [VetData]
}

struct VetData: Decodable {
    let vet: Vet
    let vet_distance: Double
}

struct Vet: Decodable {
    let vet_id: String
    let vet_name: String
    let vet_description: String
    let vet_rating: Double
    let vet_open_hour: String
    let vet_close_hour: String
    let vet_image: String
}
