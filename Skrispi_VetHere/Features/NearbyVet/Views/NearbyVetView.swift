//
//  NearbyVetView.swift
//  Skrispi_VetHere
//
//  Created by Christian Gunawan on 01/12/24.
//


import SwiftUI

struct NearbyVetView: View {
    @EnvironmentObject var router: Router
    @ObservedObject var authViewModel: AuthViewModel
    @ObservedObject var viewModel: NearbyVetListViewModel =  NearbyVetListViewModel(locationManager: LocationManager())
    
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
                            VetCardComponentView(vet: vet)
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
