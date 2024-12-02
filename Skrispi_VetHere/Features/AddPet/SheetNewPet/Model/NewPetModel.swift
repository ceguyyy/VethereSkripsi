//
//  Pet.swift
//  Skrispi_VetHere
//
//  Created by Christian Gunawan on 20/11/24.
//

import Foundation

class NewPetModel {
    var petTypeId: String
    var breedId: String
    var petImage: Data?
    var petName: String
    var petColor: String
    var petDOB: Date

    init(petTypeId: String, breedId: String, petImage: Data?, petName: String, petColor: String, petDOB: Date) {
        self.petTypeId = petTypeId
        self.breedId = breedId
        self.petImage = petImage
        self.petName = petName
        self.petColor = petColor
        self.petDOB = petDOB
    }
}
