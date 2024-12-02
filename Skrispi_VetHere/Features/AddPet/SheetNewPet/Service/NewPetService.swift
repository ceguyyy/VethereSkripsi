//
//  NewPetService.swift
//  Skrispi_VetHere
//
//  Created by Christian Gunawan on 02/12/24.
//


import Foundation

class NewPetService {
    
    private let baseURL: String
    private let decoder: JSONDecoder

    init() {
            self.baseURL = "http://localhost:8000/pet"
            self.decoder = JSONDecoder()
            self.decoder.dateDecodingStrategy = .iso8601
        }
    
    func savePet(pet: NewPet,token: String, completion: @escaping (Result<Void, Error>) -> Void) {
        guard let url = URL(string: "\(baseURL)/create") else {
            completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Invalid server URL"])))
            return
        }

        let boundary = UUID().uuidString
        var request = URLRequest(url: url)
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        request.httpMethod = "POST"
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        
        
        

        var body = Data()

        func appendFormField(named name: String, value: String) {
            body.append("--\(boundary)\r\n".data(using: .utf8)!)
            body.append("Content-Disposition: form-data; name=\"\(name)\"\r\n\r\n".data(using: .utf8)!)
            body.append("\(value)\r\n".data(using: .utf8)!)
        }

        func appendFileField(named name: String, fileName: String, mimeType: String, fileData: Data) {
            body.append("--\(boundary)\r\n".data(using: .utf8)!)
            body.append("Content-Disposition: form-data; name=\"\(name)\"; filename=\"\(fileName)\"\r\n".data(using: .utf8)!)
            body.append("Content-Type: \(mimeType)\r\n\r\n".data(using: .utf8)!)
            body.append(fileData)
            body.append("\r\n".data(using: .utf8)!)
        }

        appendFormField(named: "pet_type_id", value: pet.petTypeID)
        appendFormField(named: "breed_id", value: pet.breedID)
        appendFormField(named: "pet_name", value: pet.petName)
        appendFormField(named: "pet_color", value: pet.petColor)

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        appendFormField(named: "pet_dob", value: dateFormatter.string(from: pet.petDOB))

        if let imageData = pet.petImage {
            appendFileField(named: "pet_image", fileName: "pet.jpg", mimeType: "image/jpeg", fileData: imageData)
        }

        body.append("--\(boundary)--\r\n".data(using: .utf8)!)
        request.httpBody = body

        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            if let response = response as? HTTPURLResponse {
                if response.statusCode == 200 {
                    let errorMessage = "Pet saved successfully"
                    completion(.success(()))
                } else {
                    let responseBody = data.flatMap { String(data: $0, encoding: .utf8) } ?? "No response body"
                    let errorMessage = "Failed to save pet. Status Code: \(response.statusCode), Response: \(responseBody)"
                    completion(.failure(NSError(domain: "", code: response.statusCode, userInfo: [NSLocalizedDescriptionKey: errorMessage])))
                }
            }
        }.resume()
    }
}
