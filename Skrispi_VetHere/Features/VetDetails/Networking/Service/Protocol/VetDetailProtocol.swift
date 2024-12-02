//
//  VetDetailProtocol.swift
//  Skrispi_VetHere
//
//  Created by Christian Gunawan on 01/12/24.
//

import Combine
import Foundation

protocol VetDetailProtocol {
    func fetchVetDetail(
        token: String,
        vetId: String
    ) -> AnyPublisher<VetDetailModel, Error>
    
}
