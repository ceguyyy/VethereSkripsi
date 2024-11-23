import SwiftUI
import Combine

class NearbyVetListViewModel: ObservableObject {
    @Published var vets: [VetModel] = []
    @Published var isLoading = false
    @Published var error: Error?
    @Published var searchText: String = ""
    
    private var cancellables = Set<AnyCancellable>()
    private let vetService: APIServiceProtocol
    
    @ObservedObject var locationVM: LocationManager

    
    var filteredVets: [VetModel] {
        if searchText.isEmpty {
            return vets
        } else {
            return vets.filter { $0.name.localizedCaseInsensitiveContains(searchText) }
        }
    }
    
    func fetchLocation() {
        if let latitude = locationVM.latitude,
           let longitude = locationVM.longitude {
            fetchVetList(latitude: latitude, longitude: longitude)
        } else {
            print("Location is not available.")
        }
    }

    init(locationVM: LocationManager, vetService: APIServiceProtocol = APIService()) {
        self.locationVM = locationVM
        self.vetService = vetService

        locationVM.$latitude
            .combineLatest(locationVM.$longitude)
            .sink { [weak self] latitude, longitude in
                guard let latitude = latitude, let longitude = longitude else { return }
                self?.fetchVetList(latitude: latitude, longitude: longitude)
            }
            .store(in: &cancellables)
        
        locationVM.requestLocationPermission()
    }
    
    func fetchVetList(latitude: Double, longitude: Double) {
        isLoading = true
        error = nil
        
        guard let token = TokenManager.shared.token else {
            error = NSError(domain: "TokenManager", code: 0, userInfo: [NSLocalizedDescriptionKey: "Token not available."])
            isLoading = false
            return
        }

        vetService.fetchNearbyVets(token: token, latitude: latitude, longitude: longitude)
            .receive(on: DispatchQueue.main)
            .sink { completion in
                self.isLoading = false
                if case .failure(let error) = completion {
                    self.error = error
                    print("Error fetching vet list: \(error)")
                }
            } receiveValue: { vets in
                self.vets = vets
            }
            .store(in: &cancellables)
    }
}