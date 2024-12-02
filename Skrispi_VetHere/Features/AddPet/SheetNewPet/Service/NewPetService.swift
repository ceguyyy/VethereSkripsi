//
//  NewPetService.swift
//  Skrispi_VetHere
//
//  Created by Christian Gunawan on 02/12/24.
//


import Foundation

class NewPetService {
    func savePet(pet: NewPet, completion: @escaping (Result<Void, Error>) -> Void) {
        guard let url = URL(string: "http://localhost:8000/pet/create") else {
            completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Invalid server URL"])))
            return
        }
        
        let boundary = UUID().uuidString
        var request = URLRequest(url: url)
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
        
        appendFormField(named: "pet_type_ID", value: pet.petTypeID)
        appendFormField(named: "breed_ID", value: pet.breedID)
        appendFormField(named: "pet_name", value: pet.petName)
        appendFormField(named: "Pet_color", value: pet.petColor)
        appendFormField(named: "pet_dob", value: ISO8601DateFormatter().string(from: pet.petDOB))
        
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
            
            if let response = response as? HTTPURLResponse, response.statusCode == 201 {
                completion(.success(()))
            } else {
                completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Failed to save pet."])))
            }
        }.resume()
    }
}
