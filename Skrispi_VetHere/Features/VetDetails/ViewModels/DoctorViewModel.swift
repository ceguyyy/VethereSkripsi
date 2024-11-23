//import Foundation
//import Combine
//
//class DoctorViewModel: ObservableObject {
//    @Published var doctors: [DoctorModel] = []
//    @Published var isLoading: Bool = false
//    @Published var errorMessage: String? = nil
//
//    private var cancellables: Set<AnyCancellable> = []
//    private let apiService: APIServiceProtocol
//
//    // Inject APIService dependency
//
//    init(apiService: APIServiceProtocol = APIService()) {
//        self.apiService = apiService
//    }
//
//
//    // Fetch doctor list from API
//    func fetchDoctorList(vetId: String) {
//        isLoading = true
//        errorMessage = nil
//        
//        guard let token = TokenManager.shared.token else {
//            handleError(message: "Token not available.")
//            return
//        }
//
//        apiService.fetchDoctorList(token: token, vetId: vetId)
//            .receive(on: DispatchQueue.main)
//            .sink(receiveCompletion: { [weak self] completion in
//                switch completion {
//                case .finished:
//                    break
//                case .failure(let error):
//                    self?.handleError(message: "Failed to fetch doctor list: \(error.localizedDescription)")
//                }
//                self?.isLoading = false
//            }, receiveValue: { [weak self] doctors in
//                self?.doctors = doctors
//            })
//            .store(in: &cancellables)
//    }
//
//    // Handle errors
//    private func handleError(message: String) {
//        errorMessage = message
//        isLoading = false
//        print("Error: \(message)")
//    }
//}
