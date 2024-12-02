//
//  MyPetViewModel 2.swift
//  Skrispi_VetHere
//
//  Created by Christian Gunawan on 02/12/24.
//


import Combine
import Foundation

class MyPetViewModel: ObservableObject {
    @Published var pets: [PetModel] = []
    @Published var isLoading: Bool = false
    @Published var error: Error?
    @Published var showError: Bool = false
    
    private var cancellables = Set<AnyCancellable>()
    private let service: MyPetProtocol
    
    init(service: MyPetProtocol = PetService()) {
        self.service = service
        fetchPetList()
    }
    
    func fetchPetList() {
        isLoading = true
        error = nil
        showError = false
        
        guard let token = TokenManager.shared.token else {
            error = NSError(domain: "TokenManager", code: 0, userInfo: [NSLocalizedDescriptionKey: "Token not available."])
            isLoading = false
            showError = true
            return
        }
        
        service.fetMyPet(token: token)
            .sink(receiveCompletion: { completion in
                self.isLoading = false
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    self.error = error
                    self.showError = true
                }
            }, receiveValue: { pets in
                self.pets = pets
            })
            .store(in: &cancellables)
    }
}
