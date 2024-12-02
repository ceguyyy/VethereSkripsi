//
//  NewPetView 2.swift
//  Skrispi_VetHere
//
//  Created by Christian Gunawan on 02/12/24.
//


import SwiftUI

struct NewPetView: View {
    @State private var petName: String = ""
    @State private var petTypeID: String = ""
    @State private var breedID: String = ""
    @State private var petColor: String = ""
    @State private var petDOB: Date = Date()
    @State private var selectedUIImage: UIImage? = nil
    @State private var showImagePicker: Bool = false

    @ObservedObject private var viewModel = NewPetViewModel()

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Pet Image")) {
                    VStack {
                        if let image = selectedUIImage {
                            Image(uiImage: image)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 128, height: 128)
                                .onTapGesture {
                                    showImagePicker = true
                                }
                        } else {
                            Image(systemName: "photo")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 128, height: 128)
                                .onTapGesture {
                                    showImagePicker = true
                                }
                        }
                    }
                }
                
                Section(header: Text("Details")) {
                    TextField("Pet Name", text: $petName)
                    TextField("Pet Type ID", text: $petTypeID)
                    TextField("Breed ID", text: $breedID)
                    TextField("Pet Color", text: $petColor)
                    DatePicker("Date of Birth", selection: $petDOB, displayedComponents: .date)
                }

                Section {
                    Button(action: {
                        let newPet = NewPet(
                            petTypeID: petTypeID,
                            breedID: breedID,
                            petImage: selectedUIImage?.jpegData(compressionQuality: 0.8),
                            petName: petName,
                            petColor: petColor,
                            petDOB: petDOB
                        )
                        viewModel.savePet(pet: newPet)
                    }) {
                        if viewModel.isSaving {
                            ProgressView()
                        } else {
                            Text("Save Pet")
                        }
                    }
                    .disabled(viewModel.isSaving)
                }
            }
            .navigationBarTitle("Add New Pet", displayMode: .inline)
            .sheet(isPresented: $showImagePicker) {
                ImagePicker(image: $selectedUIImage)
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
