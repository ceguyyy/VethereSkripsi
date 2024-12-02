//
//  APIService.swift
//  Skrispi_VetHere
//
//  Created by Christian Gunawan on 01/12/24.
//


import Combine
import Foundation

class NearbyVetAPIService: NearbyVetProtocol {
    private let baseURL: String
    private let decoder: JSONDecoder

    init() {
            self.baseURL = "http://localhost:8000/vet"
            self.decoder = JSONDecoder()
            self.decoder.dateDecodingStrategy = .iso8601
        }

    func fetchNearbyVets(
        token: String,
        latitude: Double,
        longitude: Double
    ) -> AnyPublisher<[VetModel], Error> {
        guard let url = URL(string: "\(baseURL)/nearest-vets") else {
                  return Fail(error: APIError.invalidURL).eraseToAnyPublisher()
              }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        let body: [String: Double] = ["latitude": latitude, "longitude": longitude]
        request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: [])

        return URLSession.shared.dataTaskPublisher(for: request)
            .map(\.data)
            .decode(type: VetListResponse.self, decoder: decoder)
            .map { response in
                response.data.map { data in
                    VetModel(
                        id: UUID(uuidString: data.vet.vet_id) ?? UUID(),
                        detailID: UUID(),
                        name: data.vet.vet_name,
                        description: data.vet.vet_description,
                        rating: data.vet.vet_rating,
                        openHour: Double(data.vet.vet_open_hour) ?? 0.0,
                        closeHour: Double(data.vet.vet_close_hour) ?? 0.0,
                        image: data.vet.vet_image,
                        range: data.vet_distance,
                        address: "0",
                        createdAt: Date(),
                        updatedAt: Date()
                    )
                }
            }
            .eraseToAnyPublisher()
    }
}
