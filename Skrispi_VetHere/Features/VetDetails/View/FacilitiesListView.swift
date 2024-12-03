//
//  FacilitiesListView.swift
//  Skrispi_VetHere
//
//  Created by Christian Gunawan on 03/12/24.
//


import SwiftUI

struct FacilitiesListView: View {
    var facilities: [FacilityModel]

    var body: some View {
        VStack {
            Text("Facilities:")
                .font(.headline)
            
            // Use List to display the facilities
            List(facilities, id: \.id) { facility in
                Text(facility.facilityName)
                    .font(.title2)
            }
            .listStyle(PlainListStyle()) // Optional: can remove if you prefer default style
            .padding(.horizontal)
        }
    }
}
