//
//  MyPetService.swift
//  Skrispi_VetHere
//
//  Created by Christian Gunawan on 02/12/24.
//

import Foundation
import Combine


class PetService: MyPetProtocol {
    private let baseURL: String
    private let decoder: JSONDecoder
    
    init() {
        self.baseURL = "http://localhost:8000/pet"
        self.decoder = JSONDecoder()
        self.decoder.dateDecodingStrategy = .iso8601
    }
    func fetchMyPet(token: String) -> AnyPublisher<[PetModel], any Error> {
        guard let url = URL(string: baseURL + "/all") else {
            return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        print("Request: \(request)")

        
        return URLSession.shared.dataTaskPublisher(for: request)
            .tryMap { data, response in
                guard let httpResponse = response as? HTTPURLResponse else {
                    throw APIError.invalidResponse
                }
                guard httpResponse.statusCode == 200 else {
                    throw httpResponse.statusCode == 401 ? APIError.serverError : APIError.invalidResponse
                }
                
                let json = try JSONSerialization.jsonObject(with: data) as? [String: Any]
                guard let meta = json?["meta"] as? [String: Any], meta["success"] as? Bool == true,
                      let dataArray = json?["data"] as? [[String: Any]] else {
                    throw APIError.parsingError
                }

                return try dataArray.compactMap { dict -> PetModel? in
                    guard let id = UUID(uuidString: dict["pet_id"] as? String ?? ""),
                          let name = dict["pet_name"] as? String,
                          let image = dict["pet_image"] as? String else {
                        return nil
                    }
                    return PetModel(
                        id: id,
                        userID: UUID(), // Replace with actual data if available
                        petTypeID: UUID(),
                        medicalRecordID: UUID(),
                        breedID: UUID(),
                        image: image,
                        name: name,
                        color: "Unknown", // Replace with actual data if available
                        dob: Date(), // Replace with actual data if available
                        weight: 0.0, // Replace with actual data if available,
                        createdAt: Date(),
                        updatedAt: Date()
 
                    )
                }
            }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
   
    
        
    


        
}
