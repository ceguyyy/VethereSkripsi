import SwiftUI

struct BookChoosePetView: View {
    @EnvironmentObject var router: Router
    @ObservedObject var petViewModel: MyPetViewModel
    @State private var selectedPet: PetModel?
    var vet: VetModel?
    var doctor: DoctorModel?
    @State private var showNewPetSheet = false
    
    var body: some View {
        VStack {
            if petViewModel.isLoading {
                ProgressView("Loading pets...")
                    .padding()
            } else if petViewModel.showError {
                Text("Error loading pets. Please try again.")
                    .foregroundColor(.red)
                    .padding()
            } else {
                List {
                    Section(header: Text("Hewan peliharaan")) {
                        ForEach(petViewModel.pets) { pet in
                            HStack {
                                if let url = URL(string: pet.image) {
                                    AsyncImage(url: url) { phase in
                                        switch phase {
                                        case .empty:
                                            ProgressView()
                                        case .success(let image):
                                            image
                                                .resizable()
                                                .scaledToFill()
                                                .frame(width: 36, height: 36)
                                                .clipped()
                                        case .failure:
                                            Image(systemName: "photo")
                                                .resizable()
                                                .frame(width: 36, height: 36)
                                        @unknown default:
                                            EmptyView()
                                        }
                                    }
                                } else {
                                    Image(systemName: "photo")
                                        .resizable()
                                        .frame(width: 36, height: 36)
                                }
                                
                                VStack(alignment: .leading) {
                                    Text(pet.name)
                                        .font(.body)
                                    Text(pet.petTypeId.uuidString)
                                        .font(.caption)
                                        .foregroundColor(.gray)
                                }
                                Spacer()
                                Image(systemName: "chevron.forward")
                                    .foregroundColor(.blue)
                            }
                            .padding(.vertical, 8)
                            .cornerRadius(8)
                            .onTapGesture {
                                selectedPet = pet
                            }
                        }
                    }
                }
                VStack {
                    HStack {
                        Text("Peliharaan Baru")
                            .onTapGesture {
                                showNewPetSheet = true
                            }
                            .foregroundColor(.blue)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .cornerRadius(8)
                            .overlay(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(Color.black, lineWidth: 0.5)
                            )
                    }
                    .padding(.horizontal)
                }

                HStack {
                    HStack{
                        Text("Pilih Lanjutkan")
                        Spacer()
                        Image(systemName: "chevron.right")
                    }
                    .padding()
                        
                }  .onTapGesture {
                    if let pet = selectedPet {
                        router.push(.chooseSchedule(vet: vet ?? VetModel(id: UUID(), detailId: UUID(), name: "", description: "", rating: 1, openHour: 1, closeHour: 1, image: "", createdAt: Date.now, updatedAt: Date.now, range: 1, address: ""), doctor: doctor ?? DoctorModel(id: UUID(), vetId: UUID(), specializationId: UUID(), name: "", rating: 1, creadtedAt: Date.now, updatedAt: Date.now, image: ""), pet: selectedPet ?? PetModel(id: UUID(), userId: UUID(), petTypeId: UUID(), medicalRecordId: UUID(), breedId: UUID(), image: "", name: "", color: "", dob: Date.now, createdAt: Date.now, updatedAt: Date.now, weight: 10)))
                    } else {
                        print("No pet selected")
                    }
                }
                .disabled(selectedPet == nil)
                .foregroundColor(selectedPet == nil ? Color.black : Color.white)
                
                .frame(maxWidth: .infinity)
                .background(selectedPet == nil ? Color.gray : Color.blue)
                .cornerRadius(8)
                .padding(.horizontal)
                .listStyle(InsetGroupedListStyle())
                .onAppear {
                    petViewModel.fetchPetList()
                }
            }
        }
        .navigationTitle("Pilih Hewan Peliharaan")
        .padding(.top, 10)
        .sheet(isPresented: $showNewPetSheet) {
                    NewPetView()
                }
    }
}



