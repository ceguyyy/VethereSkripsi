import SwiftUI

struct NewPetView: View {
    @State private var petImage: Image? = nil
    @State private var petName: String = ""
    @State private var petWeight: String = ""
    @State private var selectedPetType: String = "Select Type"
    @State private var petBirthDate: Date = Date()
    @State private var petBreed: String = ""
    @State private var petColor: String = ""
    @State private var showImagePicker: Bool = false
    @State private var selectedUIImage: UIImage? = nil
    
    let petTypes = ["Anjing", "Kucing", "Eksotis", "Lainnya"]
    
    @Environment(\.presentationMode) var presentationMode
    
    @ObservedObject var viewModel = NewPetViewModel()
    
    var body: some View {
        NavigationView {
            List {
                Section {
                    VStack {
                        if let petImage = petImage {
                            petImage
                                .resizable()
                                .scaledToFit()
                                .frame(width: 128, height: 128)
                                .onTapGesture {
                                    showImagePicker = true
                                }
                        } else {
                            Image("imageupload")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 128, height: 128)
                                .onTapGesture {
                                    showImagePicker = true
                                }
                        }
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.top)
                }
                
                Section {
                    TextField("Nama Peliharaan", text: $petName)
                        .textFieldStyle(PlainTextFieldStyle())
                    TextField("Berat Peliharaan (kg)", text: $petWeight)
                        .keyboardType(.decimalPad)
                        .textFieldStyle(PlainTextFieldStyle())
                }
                
                Section {
                    Picker("Tipe Peliharaan", selection: $selectedPetType) {
                        ForEach(petTypes, id: \.self) { petType in
                            Text(petType).tag(petType)
                        }
                    }
                    .pickerStyle(MenuPickerStyle())
                    
                    DatePicker("Tanggal Lahir", selection: $petBirthDate, displayedComponents: .date)
                }
                Section {
                    TextField("Breed", text: $petBreed)
                        .textFieldStyle(PlainTextFieldStyle())
                    TextField("Warna Peliharaan", text: $petColor)
                        .textFieldStyle(PlainTextFieldStyle())
                }
                
                Section {
                    VStack {
                        if viewModel.isSaving {
                            ProgressView("Saving...")
                        } else {
                            Text("Tambah Peliharaan")
                                .onTapGesture {
                                    let newPet = NewPet(
                                        name: petName,
                                        weight: petWeight,
                                        type: selectedPetType,
                                        birthDate: petBirthDate,
                                        breed: petBreed,
                                        color: petColor,
                                        imageData: selectedUIImage?.jpegData(compressionQuality: 0.8)
                                    )
                                    viewModel.savePet(pet: newPet)
                                }
                                .foregroundColor(.blue)
                                .cornerRadius(8)
                        }
                    }
                    .frame(maxWidth: .infinity)
                }
            }
            .navigationBarTitle("Add New Pet", displayMode: .inline)
            .navigationBarItems(leading: Button("Back") {
                self.presentationMode.wrappedValue.dismiss()
            })
            .sheet(isPresented: $showImagePicker) {
                ImagePicker(image: $selectedUIImage)
            }
            .onChange(of: selectedUIImage) { newImage in
                if let uiImage = newImage {
                    petImage = Image(uiImage: uiImage)
                }
            }
            .alert(isPresented: .constant(viewModel.errorMessage != nil)) {
                Alert(
                    title: Text("Error"),
                    message: Text(viewModel.errorMessage ?? ""),
                    dismissButton: .default(Text("OK"))
                )
            }
        }
    }
}
