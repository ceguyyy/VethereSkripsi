import SwiftUI
import Combine

class MyPetViewModel: ObservableObject {
    @Published var pets: [PetModel] = []
    @Published var isLoading = false
    @Published var error: Error?
    @Published var showError = false
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
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
        
        fetchMockPetList(token: token)
            .sink { completion in
                self.isLoading = false
                switch completion {
                case .finished:
                    print("Mock pet list fetched successfully!")
                case .failure(let error):
                    self.error = error
                    print("Error fetching pet list: \(error)")
                    self.showError = true
                }
            } receiveValue: { pets in
                self.pets = pets
            }
            .store(in: &cancellables)
    }
    

    private func fetchMockPetList(token: String) -> AnyPublisher<[PetModel], Error> {
        let mockPets = [
            PetModel(id: UUID(), userId: UUID(), petTypeId: UUID(), medicalRecordId: UUID(), breedId: UUID(), image: "https://upload.wikimedia.org/wikipedia/id/5/5f/Original_Doge_meme.jpg", name: "anjing", color: "", dob: Date.now, createdAt: Date.now, updatedAt: Date.now, weight: 10),
            PetModel(id: UUID(), userId: UUID(), petTypeId: UUID(), medicalRecordId: UUID(), breedId: UUID(), image: "https://upload.wikimedia.org/wikipedia/id/5/5f/Original_Doge_meme.jpg", name: "anjing", color: "", dob: Date.now, createdAt: Date.now, updatedAt: Date.now, weight: 10),
            PetModel(id: UUID(), userId: UUID(), petTypeId: UUID(), medicalRecordId: UUID(), breedId: UUID(), image: "https://upload.wikimedia.org/wikipedia/id/5/5f/Original_Doge_meme.jpg", name: "anjing", color: "", dob: Date.now, createdAt: Date.now, updatedAt: Date.now, weight: 10)
           
        ]
        
        return Just(mockPets)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
}
