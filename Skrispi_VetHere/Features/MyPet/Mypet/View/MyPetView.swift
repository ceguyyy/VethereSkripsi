import SwiftUI
import Combine

struct MyPetView: View {
    @EnvironmentObject var router: Router
    @ObservedObject var viewModel = MyPetViewModel()
    @State private var showNewPetSheet = false

    var body: some View {
        NavigationView {
            VStack {
                List {
                    if viewModel.isLoading {
                        ProgressView()
                    } else if let error = viewModel.error {
                        Text("Error: \(error.localizedDescription)")
                            .foregroundColor(.red)
                    } else {
                        ForEach(viewModel.pets) { pet in
                            VStack {
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
                                            .frame(width: 50, height: 50)
                                    }
                                    
                                    VStack(alignment: .leading) {
                                        Text(pet.name)
                                            .font(.headline)
                                        Text(pet.petTypeId.uuidString)
                                            .font(.subheadline)
                                            .foregroundColor(.gray)
                                    }
                                }
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
            }
            .navigationTitle("Peliharaan") 
        }
    }
}

