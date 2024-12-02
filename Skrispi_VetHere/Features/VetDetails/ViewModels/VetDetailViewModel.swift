//
//  VetDetailViewModel.swift
//  Skrispi_VetHere
//
//  Created by Christian Gunawan on 14/11/24.
//

import SwiftUI
import Combine

class VetDetailViewModel: ObservableObject {
    @Published var vetDetail: VetDetailModel?
    @Published var isLoading = false
    @Published var error: String?
    @Published var showError = false
    private var hasFetched = false

    private var cancellables = Set<AnyCancellable>()
    private let apiService: VetDetailProtocol

    init(apiService: VetDetailProtocol = VetDetailAPIService()) {
        self.apiService =  apiService
    }

    func fetchVetDetail(vetID: String) {
        guard !hasFetched else {
            print("Vet details already fetched.")
            return
        }
        hasFetched = true
        isLoading = true
        error = nil
        showError = false

        guard let token = TokenManager.shared.token else {
            handleError(message: "Token not available.")
            return
        }

        apiService.fetchVetDetail(token: token, vetID: vetID)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    self?.handleError(message: "Failed to fetch vet details: \(error.localizedDescription) for vetID: \(vetID)")
                }
                self?.isLoading = false
            }, receiveValue: { [weak self] fetchedVetDetail in
                self?.vetDetail = fetchedVetDetail
                print("Vet Detail Data: \(fetchedVetDetail)")
            })
            .store(in: &cancellables)
    }

    func reset() {
        hasFetched = false
    }

    private func handleError(message: String) {
        error = message
        showError = true
        isLoading = false
        print("Error: \(message)")
    }
}
