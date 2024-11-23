//
//  APIServiceProtocol.swift
//  Skrispi_VetHere
//
//  Created by Christian Gunawan on 19/11/24.
//


import Combine
import Foundation

protocol APIServiceProtocol {
    func fetchNearbyVets(
        token: String,
        latitude: Double,
        longitude: Double
    ) -> AnyPublisher<[VetModel], Error>
    
    func fetchVetDetail(
        token: String,
        vetId: String
    ) -> AnyPublisher<VetDetailModel, Error>
    
//    func fetchDoctorList(
//        token: String,
//        vetId: String
//    ) -> AnyPublisher<DoctorModel, Error>
}
