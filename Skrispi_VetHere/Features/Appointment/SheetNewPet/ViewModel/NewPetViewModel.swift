//
//  NewPetViewModel.swift
//  Skrispi_VetHere
//
//  Created by Christian Gunawan on 20/11/24.
//


import Foundation
import Combine

class NewPetViewModel: ObservableObject {
    @Published var isSaving: Bool = false
    @Published var errorMessage: String?

    func savePet(pet: NewPet) {
        guard let url = URL(string: "https://example.com/api/pets") else {
            self.errorMessage = "Invalid server URL"
            return
        }

        do {
            let encoder = JSONEncoder()
            encoder.dateEncodingStrategy = .iso8601 // Format date for JSON
            let jsonData = try encoder.encode(pet)
            
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpBody = jsonData
            
            self.isSaving = true
            let _ = URLSession.shared.dataTask(with: request) { data, response, error in
                DispatchQueue.main.async {
                    self.isSaving = false
                    
                    if let error = error {
                        self.errorMessage = "Error saving pet: \(error.localizedDescription)"
                        return
                    }
                    
                    // Handle success or failure based on response
                    if let response = response as? HTTPURLResponse, response.statusCode == 200 {
                        print("Pet saved successfully")
                    } else {
                        self.errorMessage = "Failed to save pet."
                    }
                }
            }.resume()
            
        } catch {
            self.errorMessage = "Error encoding pet data: \(error.localizedDescription)"
        }
    }
}
