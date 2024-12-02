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

    private let service = NewPetService()

    func savePet(pet: NewPetModel) {
        self.isSaving = true
        self.errorMessage = nil

        guard let token = TokenManager.shared.token else {
            self.errorMessage = "Token not available."
            self.isSaving = false
            return
        }

        service.savePet(pet: pet, token: token) { result in
            DispatchQueue.main.async {
                self.isSaving = false
                switch result {
                case .success:
                    self.errorMessage = "Pet saved successfully"
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                    
                }
            }
        }
    }
}
