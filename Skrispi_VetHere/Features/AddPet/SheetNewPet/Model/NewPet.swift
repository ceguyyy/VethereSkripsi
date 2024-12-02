//
//  Pet.swift
//  Skrispi_VetHere
//
//  Created by Christian Gunawan on 20/11/24.
//

import Foundation

class NewPet: Codable {
    let petTypeID: String
    let breedID: String
    let petImage: Data?
    let petName: String
    let petColor: String
    let petDOB: Date
    
    init(petTypeID: String, breedID: String, petImage: Data?, petName: String, petColor: String, petDOB: Date) {
        self.petTypeID = petTypeID
        self.breedID = breedID
        self.petImage = petImage
        self.petName = petName
        self.petColor = petColor
        self.petDOB = petDOB
    }   
}
