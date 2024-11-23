//
//  VetCardComponent.swift
//  Skrispi_VetHere
//
//  Created by Christian Gunawan on 12/11/24.
//


import SwiftUI

struct VetCardComponent: View {
    var vet: VetModel
    
    var body: some View {
        VStack(alignment: .leading) {
            if let imageURL = URL(string: vet.image) {
                AsyncImage(url: imageURL) { image in
                    image.resizable()
                        .frame(width: 361, height: 200)
                        .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                } placeholder: {
                    ProgressView()
                        .frame(width: 361, height: 200)
                }
            } else {
                let imageURL = URL(string: "https://upload.wikimedia.org/wikipedia/commons/thumb/8/8e/Visit_of_Tim_Cook_to_the_European_Commission_-_P061904-946789.jpg/1200px-Visit_of_Tim_Cook_to_the_European_Commission_-_P061904-946789.jpg")
                AsyncImage(url: imageURL) { image in
                    image.resizable()
                        .frame(width: 361, height: 200)
                        .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                } placeholder: {
                    ProgressView()
                        .frame(width: 361, height: 200)
                }
            }
            VStack(alignment: .leading, spacing: 8) {
                Text(vet.name)
                    .padding(.bottom, 2)
                    .font(.system(size: 22, weight: .bold))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .foregroundColor(Color("TextColor"))
                HStack(spacing: 2) {
                   
                    ForEach(0..<vet.rating, id: \.self) { _ in
                        Image(systemName: "star.fill")
                            .foregroundColor(.yellow)
                            .font(.system(size: 12))
                    }
                    ForEach(0..<(5 - vet.rating), id: \.self) {
                        _ in Image(systemName: "star")
                            .foregroundColor(.yellow)
                            .font(.system(size: 12))
                    }
                    Text("•")
                        .foregroundColor(.gray)
                        .font(.system(size: 12))
                    HStack {
                        Image(systemName: "map.fill")
                        Text("\(vet.range, specifier: "%.1f") Km")
                            .font(.system(size: 12))
                            .foregroundColor(Color("TextColor"))
                    }
                    Text("•")
                        .foregroundColor(.gray)
                        .font(.system(size: 12))
                    
                    HStack {
                        Image(systemName: "clock.fill")
                        Text("Until \(vet.closeHour, specifier: "%.2f")")
                            .font(.system(size: 12))
                            .foregroundColor(Color("TextColor"))
                    }
                }
                Text(vet.address)
                    .font(.system(size: 13))
                    .foregroundColor(.black)
                    .foregroundColor(Color("TextColor"))
                    .lineLimit(2)
            }
            .padding(12)
        }
        .padding(.bottom)
        .foregroundColor(Color("TextColor"))
        .background(Color("ColorCard"))
        .frame(width: 361)
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .cornerRadius(10)
    }
}
