//
//  MyPetProtocol.swift
//  Skrispi_VetHere
//
//  Created by Christian Gunawan on 02/12/24.
//


import Combine
import Foundation

protocol MyPetProtocol {
    func fetMyPet(token: String) -> AnyPublisher<[PetModel], Error>
}
