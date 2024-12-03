//
//  VetDetailResponse 2.swift
//  Skrispi_VetHere
//
//  Created by Christian Gunawan on 03/12/24.
//


import Foundation

struct VetDetailResponse: Decodable {
    let data: VetDetailData
}

struct VetDetailData: Decodable {
    let vet_id: String
    let vet_name: String
    let vet_description: String
    let vet_rating: Double
    let vet_open_hour: String
    let vet_close_hour: String
    let vet_image: String
    let vet_doctors: [Doctor]
    let vet_facilities: [Facility]
    let vet_detail: VetDetail
}

struct VetDetail: Decodable {
    let vet_detail_id: String
    let vet_phone_number: String
    let vet_latitude: Double
    let vet_longitude: Double
}

struct Doctor: Decodable {
    let doctor_id: String
    let doctor_name: String
    let doctor_rating: Double
    let specialization: Specialization
}

struct Specialization: Decodable {
    let specialization_id: String
    let specialization_name: String
}


struct Facility: Decodable {
    let facility_id: String
    let facility_name: String
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


struct Meta: Codable {
    let success: Bool
    let message: String
}


struct VetFacility: Codable {
    let facility_id: String
    let facility_name: String
}

