//
//  PetRowView.swift
//  Skrispi_VetHere
//
//  Created by Daniel Ian on 02/12/24.
//

import SwiftUI

struct PetRowComponentView: View {
    let pet: PetModel
    var onTap: () -> Void

    var body: some View {
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
                Text(pet.petTypeID.uuidString)
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
            onTap()
        }
    }
}
