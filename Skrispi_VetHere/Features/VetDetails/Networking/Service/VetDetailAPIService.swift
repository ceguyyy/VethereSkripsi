//
//  VetDetailAPIService.swift
//  Skrispi_VetHere
//
//  Created by Christian Gunawan on 01/12/24.
//

import Combine
import Foundation

class VetDetailAPIService: VetDetailProtocol {

    private let baseURL: String
    private let decoder: JSONDecoder

    init() {
            self.baseURL = "http://localhost:8000/vet"
            self.decoder = JSONDecoder()
            self.decoder.dateDecodingStrategy = .iso8601
        }


    func fetchVetDetail(
            token: String,
            vetID: String
        ) -> AnyPublisher<VetDetailModel, Error> {
            guard let url = URL(string: "\(baseURL)/details") else {
                return Fail(error: APIError.invalidURL).eraseToAnyPublisher()
            }

            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")

            let body: [String: String] = ["vet_id": vetID]

            request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: [])

            return URLSession.shared.dataTaskPublisher(for: request)
                .map(\.data)
                .decode(type: VetDetailResponse.self, decoder: decoder)
                .map { response in
                    VetDetailModel(
                        id: UUID(uuidString: response.data.vet_id) ?? UUID(),
                        scheduleID: UUID(uuidString: response.data.vet_detail.vet_detail_id) ?? UUID(),
                        phoneNumber: response.data.vet_detail.vet_phone_number,
                        latitude: response.data.vet_detail.vet_latitude,
                        longitude: response.data.vet_detail.vet_longitude,
                        createdAt: Date(),
                        updatedAt: Date()
                    )
                }
                .eraseToAnyPublisher()
        }
    
}
