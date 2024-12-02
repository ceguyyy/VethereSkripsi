//
//  Pet.swift
//  Skrispi_VetHere
//
//  Created by Christian Gunawan on 20/11/24.
//

import Foundation

class NewPet {
    var petTypeID: String
    var breedID: String
    var petImage: Data?
    var petName: String
    var petColor: String
    var petDOB: Date

    init(petTypeID: String, breedID: String, petImage: Data?, petName: String, petColor: String, petDOB: Date) {
        self.petTypeID = petTypeID
        self.breedID = breedID
        self.petImage = petImage
        self.petName = petName
        self.petColor = petColor
        self.petDOB = petDOB
    }
}
