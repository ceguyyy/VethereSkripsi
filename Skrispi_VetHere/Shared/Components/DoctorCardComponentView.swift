//
//  DoctorCardComponent.swift
//  Skrispi_VetHere
//
//  Created by Christian Gunawan on 18/11/24.
//
import SwiftUI

struct DoctorCardComponentView: View {
    var doctor: DoctorModel
    var bookingAction: () -> Void
    var chatAction: () -> Void
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack(spacing: 8) {
                if let imageURL = URL(string: doctor.image) {
                    AsyncImage(url: imageURL) { image in
                        image.resizable()
                            .frame(width: 88, height: 88)
                    } placeholder: {
                        ProgressView()
                            .frame(width: 88, height: 88)
                    } } else {
                        Image(systemName: "person.circle.fill")
                            .resizable()
                            .frame(width: 88, height: 88)
                            
                    }
                VStack(alignment: .leading, spacing: 8) {
                    Text(doctor.doctorName)
                        .font(.headline)
                        .bold()
                        .padding(.leading)
                    Text(doctor.specializationName)
                        .font(.caption)
                        .foregroundColor(.secondary)
                        .padding(.leading)
                    HStack {
                        ForEach(0..<doctor.doctorRating, id: \.self) { _ in
                            Image(systemName: "star.fill")
                                .foregroundColor(.yellow)
                                .font(.system(size: 12))
                        }
                    }         .padding(.leading)
                }
                Spacer()
                VStack {
                    Button(action: {
                        chatAction()
                    }) {
                        Text("Chat").font(.caption2)
                    }
                    .padding(.vertical, 8)
                    .padding(.horizontal, 16)
                    .foregroundColor(Color("TextColor"))
                    .background(Color("ColorCard"))
                    .cornerRadius(10)
                    
                    Button(action: {
                        bookingAction()
                    }) {
                        Text("Pesan").font(.caption2)
                    }
                    .padding(.vertical, 8)
                    .padding(.horizontal, 12)
                    .foregroundColor(Color("TextColor"))
                    .background(Color("ColorCard"))
                    .cornerRadius(10)
                    
                }
                .padding(.horizontal)
            }
            .foregroundColor(Color("TextColor"))
            .background(Color("DoctorCard"))
        }
        .cornerRadius(10)
        .padding()
    }
}


