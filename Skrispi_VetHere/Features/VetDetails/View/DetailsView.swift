//
//  DetailsView.swift
//  Skrispi_VetHere
//
//  Created by Christian Gunawan on 06/11/24.
//

import SwiftUI

struct DetailsView: View {
    @EnvironmentObject var router: Router
    @StateObject private var vetDetailViewModel = VetDetailViewModel()
    @State private var selectedSegment: DetailEnum = .appointment
    @State private var hasFetchedDetails = false
    var vet: VetModel
    var vetDetail: VetDetail?
    var doctor: DoctorModel?
   
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                if let imageURL = URL(string: vet.image) {
                    AsyncImage(url: imageURL) { image in
                        image.resizable()
                            .scaledToFill()
                            .frame(width: 393, height: 216)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                    } placeholder: {
                        ProgressView()
                            .frame(width: 393, height: 216)
                    }
                } else {
                    Image(systemName: "person.circle.fill")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 393, height: 216)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                }
                
                VStack(alignment: .leading, spacing: 4) {
                    Text(vet.name)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .padding(.horizontal)
                    
                    Text("\(vet.range, specifier: "%.1f") Km")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                        .padding(.horizontal)
                    
                    Text("Buka sampai \(vet.closeHour, specifier: "%.2f")")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                        .padding(.horizontal)
                }
                
                Picker("Options", selection: $selectedSegment) {
                    ForEach(DetailEnum.allCases) { segment in
                        Text(segment.rawValue).tag(segment)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding(.horizontal)
                
                Group {
                    switch selectedSegment {
                    case .appointment:
                        DoctorCardComponent(
                            doctor: doctor ?? DoctorModel(
                                DoctorId: UUID(),
                                VetId: UUID(),
                                SpecializationId: UUID(),
                                DoctorName: "Joseph",
                                DoctorRating: 5,
                                creadtedAt: Date(),
                                updatedAt: Date(),
                                image: "test"
                            ),
                            specialization: DoctorSpecializationModel(id: UUID(), name: "ahli"),
                            bookingAction: {
                                router.push(.book(vet: vet, doctor: DoctorModel(
                                    DoctorId: UUID(),
                                    VetId: UUID(),
                                    SpecializationId: UUID(),
                                    DoctorName: "Joseph",
                                    DoctorRating: 5,
                                    creadtedAt: Date(),
                                    updatedAt: Date(),
                                    image: "test")))
                            },
                            chatAction: {
                                guard let phoneNumber = vetDetailViewModel.vetDetail?.phoneNumber else {
                                    print("Phone number is unavailable")
                                    return
                                }
                                openWhatsAppManager(
                                    phoneNumber: phoneNumber,
                                    message: "Hello, Selamat siang saya ingin berkonsultasi dengan Dr. Joseph"
                                )
                            }
                        )
                    case .information:
                        MapAndAddressComponent(vet: vet, vetDetailViewModel: vetDetailViewModel)
                    }
                }
            }
            .onAppear {
                if !hasFetchedDetails {
                    vetDetailViewModel.fetchVetDetail(vetId: vet.id.uuidString)
                    hasFetchedDetails = true
                }
            }
        }
        .navigationTitle(vet.name)
        .navigationBarTitleDisplayMode(.inline)
    }
}
