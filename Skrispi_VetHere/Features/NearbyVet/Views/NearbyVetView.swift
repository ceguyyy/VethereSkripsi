import SwiftUI

struct NearbyVetView: View {
    @EnvironmentObject var router: Router
    @ObservedObject var authVM: AuthViewModel
    @ObservedObject var viewModel = NearbyVetListViewModel(locationVM: LocationManager())
    
    var body: some View {
        NavigationView {
            VStack {
                ScrollView {
                    if viewModel.isLoading {
                        ProgressView()
                    } else if let error = viewModel.error {
                        Text("Error: \(error.localizedDescription)")
                            .foregroundColor(.red)
                    } else {
                        ForEach(viewModel.filteredVets) { vet in
                            VetCardComponent(vet: vet)
                                .onTapGesture {
                                    router.push(.details(vet: vet))
                                }
                        }
                    }
                }
                .refreshable {
                    viewModel.fetchLocation()
                }
                .searchable(text: $viewModel.searchText)
                
                Spacer()
                
            }
            .navigationTitle("Klinik Terdekat")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        router.push(.profile)
                    }) {
                        Image(systemName: "person.fill")
                    }
                }
            }
        }
        .onAppear {
            viewModel.fetchLocation()
        }
    }
}
