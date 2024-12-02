//
//  MyPetView.swift
//  Skrispi_VetHere
//
//  Created by Christian Gunawan on 02/12/24.
//


import SwiftUI
import Combine

struct MyPetView: View {
    @EnvironmentObject var router: Router
    @ObservedObject var viewModel = MyPetViewModel()
    @State private var showNewPetSheet: Bool = false
    
    var body: some View {
        NavigationView {
            List {
                if viewModel.isLoading {
                    ProgressView("Loading...")
                        .frame(maxWidth: .infinity, alignment: .center)
                }
                else if let error = viewModel.error {
                    Text("No pets available.")
                        .font(.body)
                        .foregroundColor(.gray)
                        .frame(maxWidth: .infinity, alignment: .center)
                }
                else {
                    ForEach(viewModel.pets) { pet in
                        HStack {
                            
                            if let imageURL = URL(string: pet.image ?? "") {
                                AsyncImage(url: imageURL) { image in
                                    image.resizable()
                                        .scaledToFit()
                                } placeholder: {
                                    ProgressView()
                                }
                                .frame(width: 50, height: 50)
                            } else {
                                
                                Image(systemName: "person.circle.fill")
                                    .resizable()
                                    .frame(width: 50, height: 50)
                                    .foregroundColor(.gray)
                            }

                            VStack(alignment: .leading) {
                                Text(pet.name)
                                    .font(.headline)
                                Text(pet.petTypeID.uuidString)
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                            }
                            
                            Spacer()
                        }
                        .onTapGesture {
                            router.push(.petDetail(pet: pet))
                        }
                    }
                }

                Section {
                    HStack {
                        Text("Peliharaan Baru")
                            .onTapGesture {
                                showNewPetSheet = true
                            }
                            .foregroundColor(.blue)
                            .frame(maxWidth: .infinity)
                    }
                    .padding(.horizontal)
                    .sheet(isPresented: $showNewPetSheet) {
                        NewPetView()
                    }
                }
            }
            .navigationTitle("Peliharaan")
            .refreshable {
                viewModel.fetchPetList()
            }
            .onAppear {
                viewModel.fetchPetList()
            }
        }
    }
}
