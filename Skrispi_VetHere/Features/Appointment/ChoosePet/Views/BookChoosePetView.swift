import SwiftUI

struct BookChoosePetView: View {
    @EnvironmentObject var router: Router
    @ObservedObject var petViewModel: MyPetViewModel
    @State private var selectedPet: PetModel?
    var vet: VetModel?
    var doctor: DoctorModel?
    @State private var showNewPetSheet: Bool = false
    
    var body: some View {
        VStack {
            List {
                     Section(header: Text("Hewan peliharaan")) {
                         ForEach(petViewModel.pets) { pet in
                             PetRowComponentView(pet: pet) {
                                 selectedPet = (selectedPet == pet) ? nil : pet
                             }
                             .background(selectedPet == pet ? Color.blue.opacity(0.1) : Color.clear)
                             .cornerRadius(8)
                         }
                     }
                 } .refreshable{
                     petViewModel.fetchPetList()
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
                HStack {
                    Text("Pilih Lanjutkan")
                    Spacer()
                    Image(systemName: "chevron.right")
                }
                .padding()
            }
            .onTapGesture {
                if let pet = selectedPet {
                    router.push(
                        .chooseSchedule(
                            vet: vet ?? VetModel(id: UUID(), detailID: UUID(), name: "", description: "", rating: 1, openHour: 1, closeHour: 1, image: "", range: 1, address: "", createdAt: Date.now, updatedAt: Date.now),
                            doctor: doctor ?? DoctorModel(id: UUID(), doctorName: "CG", doctorRating: 1, specializationName: "", image: ""),
                            pet: selectedPet ?? PetModel(id: UUID(), userID: UUID(), petTypeID: UUID(), medicalRecordID: UUID(), breedID: UUID(), image: "", name: "", color: "", dob: Date.now, weight: 1, createdAt: Date.now, updatedAt: Date.now)
                        )
                    )
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
        .navigationTitle("Pilih Hewan Peliharaan")
        .padding(.top, 10)
        .sheet(isPresented: $showNewPetSheet) {
            NewPetView()
        }
    }

}



