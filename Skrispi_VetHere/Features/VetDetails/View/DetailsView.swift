//
//  DetailsView.swift
//  Skrispi_VetHere
//
//  Created by Christian Gunawan on 03/12/24.
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
                        if let doctors = vetDetailViewModel.vetDetail?.doctors {
                            DoctorListView(
                                doctors: doctors,
                                bookingAction: { doctor in
                                    router.push(.book(vet: vet, doctor: doctor))
                                },
                                chatAction: {
                                    print("NotImplemented")
                                }
                            )
                        }
                        
                    case .information:
                        MapAndAddressComponentView(
                            vet: vet,
                            vetDetailViewModel: vetDetailViewModel
                        )
                        
                        HStack{
                            Text("Facilities:")
                                .font(.headline)
                            ForEach(vetDetailViewModel.vetDetail?.facilities ?? [], id: \.id) { facility in
                                Text(facility.facilityName)
                                    .font(.caption)
                            }
                        }.padding(.horizontal)
                    }
                }
                .onAppear {
                    vetDetailViewModel.fetchVetDetail(vetID: vet.id.uuidString)
                }
            }
            .navigationTitle(vet.name)
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}
