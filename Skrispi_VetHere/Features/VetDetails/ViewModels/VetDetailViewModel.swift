//
//  VetDetailViewModel.swift
//  Skrispi_VetHere
//
//  Created by Christian Gunawan on 14/11/24.
//
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
    private var hasFetched = false // Add this property

    private var cancellables = Set<AnyCancellable>()
    private let apiService: APIServiceProtocol

    init(apiService: APIServiceProtocol = APIService()) {
        self.apiService = apiService
    }

    func fetchVetDetail(vetId: String) {
        guard !hasFetched else {
            print("Vet details already fetched.")
            return
        }
        hasFetched = true // Mark as fetched to prevent repeated calls

        isLoading = true
        error = nil
        showError = false

        guard let token = TokenManager.shared.token else {
            handleError(message: "Token not available.")
            return
        }

        apiService.fetchVetDetail(token: token, vetId: vetId)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    self?.handleError(message: "Failed to fetch vet details: \(error.localizedDescription) for vetID: \(vetId)")
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
