//
//  MapAndAddressView.swift
//  VetHereiOS
//
//  Created by Christian Gunawan on 30/10/24.
//

import SwiftUI

import SwiftUI

struct MapAndAddressComponentView: View {
    var vet: VetModel
    var vetDetail: VetDetailModel?
    var vetDetailViewModel: VetDetailViewModel
    var body: some View {
        VStack {
            if vetDetailViewModel.isLoading {
                ProgressView("Loading...")
                    .progressViewStyle(CircularProgressViewStyle())
                    .padding()
            } else if let error = vetDetailViewModel.error {
                Text("Error: \(error)")
                    .foregroundColor(.red)
                    .padding()
            } else {
                if let latitude = vetDetailViewModel.vetDetail?.latitude,
                   let longitude = vetDetailViewModel.vetDetail?.longitude {
                    MapComponentView(latitude: latitude, longitude: longitude)
                        .frame(width: 361, height: 200)
                        .padding(.horizontal)
                        .cornerRadius(10)
                } else {
                    Text("Invalid coordinates")
                        .foregroundColor(.red)
                        .padding()
                }

                Text(vet.address)
                    .padding(.horizontal)
            }
        }.cornerRadius(10)

    }
}
