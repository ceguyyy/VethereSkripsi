//
//  APIServiceProtocol.swift
//  Skrispi_VetHere
//
//  Created by Christian Gunawan on 19/11/24.
//


import Combine
import Foundation

protocol NearbyVetProtocol {
    func fetchNearbyVets(
        token: String,
        latitude: Double,
        longitude: Double
    ) -> AnyPublisher<[VetModel], Error>
}
