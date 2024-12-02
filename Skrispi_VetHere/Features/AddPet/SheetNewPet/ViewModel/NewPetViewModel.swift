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

    func savePet(pet: NewPet) {
        self.isSaving = true
        service.savePet(pet: pet) { result in
            DispatchQueue.main.async {
                self.isSaving = false
                switch result {
                case .success:
                    print("Pet saved successfully")
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                }
            }
        }
    }
}
