//
//  Pet.swift
//  Skrispi_VetHere
//
//  Created by Christian Gunawan on 20/11/24.
//


import Foundation

struct NewPet: Codable {
    var name: String
    var weight: String
    var type: String
    var birthDate: Date
    var breed: String
    var color: String
    var imageData: Data?  // Optional, as the image may not be available

    enum CodingKeys: String, CodingKey {
        case name
        case weight
        case type = "pet_type"
        case birthDate = "birth_date"
        case breed
        case color
        case imageData = "image"
    }
}
