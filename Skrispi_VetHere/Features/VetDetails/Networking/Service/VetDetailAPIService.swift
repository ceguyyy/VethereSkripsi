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
    
    
    func fetchVetDetail(token: String, vetID: String) -> AnyPublisher<VetDetailModel, Error> {
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
            .map { response in
                // Print the raw data response (as Data) for debugging
                print("Received Data: \(String(data: response.data, encoding: .utf8) ?? "Invalid Data")")
                return response.data
            }
            .decode(type: VetDetailResponse.self, decoder: decoder)
            .map { response in
                // Print the decoded response to see if it's correct
                print("Decoded Response: \(response)")
                
                // Map the doctors from the response
                let doctors = response.data.vet_doctors.map { doctor in
                    DoctorModel(
                        id: UUID(uuidString: doctor.doctor_id) ?? UUID(),
                        doctorName: doctor.doctor_name,
                        doctorRating: Int(doctor.doctor_rating),
                        specializationName: doctor.specialization.specialization_name,
                        image: ""  // Assuming image is not provided in the response
                    )
                }
                
                let facilities = response.data.vet_facilities.map { facility in
                    FacilityModel(
                        id: UUID(uuidString: facility.facility_id) ?? UUID(),
                        facilityName: facility.facility_name
                    )
                }
                
                return VetDetailModel(
                    id: UUID(uuidString: response.data.vet_id) ?? UUID(),
                    scheduleID: UUID(uuidString: response.data.vet_detail.vet_detail_id) ?? UUID(),
                    phoneNumber: response.data.vet_detail.vet_phone_number,
                    latitude: response.data.vet_detail.vet_latitude,
                    longitude: response.data.vet_detail.vet_longitude,
                    createdAt: Date(),
                    updatedAt: Date(),
                    doctors: doctors,
                    facilities: facilities
                )
            }
            .eraseToAnyPublisher()
    }
}
