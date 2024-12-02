//
//  SettingsView.swift
//  Skrispi_VetHere
//
//  Created by Christian Gunawan on 13/11/24.
//
import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var authVM: AuthViewModel
    @State private var selectedUIImage: UIImage? = nil
    @State private var showImagePicker: Bool = false
    
    var body: some View {
        VStack(spacing: 16) {
            if let user = authVM.currentUser {
                VStack(alignment: .leading, spacing: 8) {
                    HStack {
                        Spacer()
                        if let imageURL = URL(string: user.imageName ?? ""),
                           selectedUIImage == nil {
                            AsyncImage(url: imageURL) { image in
                                image.resizable()
                                    .scaledToFit()
                            } placeholder: {
                                ProgressView()
                            }
                            .frame(width: 50, height: 50)
                            .clipShape(Rectangle())
                        } else if let uiImage = selectedUIImage {
                            Image(uiImage: uiImage)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 50, height: 50)
                                .clipShape(Rectangle())
                        } else {
                            Image(systemName: "person.circle.fill")
                                .resizable()
                                .frame(width: 50, height: 50)
                                .clipShape(Rectangle())
                        }
                        Spacer()
                    }
                    .onTapGesture {
                        showImagePicker = true
                    }
                    
                    Text("Username: \(user.username)")
                        .font(.headline)
                    Text("Name: \(user.first_Name) \(user.last_Name)")
                        .font(.title)
                        .bold()
                    Text("Role: \(user.role)")
                        .font(.subheadline)
                    Text("Joined: \(user.createdAt, formatter: DateFormatter.shortDate)")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
                .padding()
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(Color(.systemGroupedBackground))
                .cornerRadius(10)
                .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
            } else {
                Text("No user information available.")
                    .foregroundColor(.red)
            }
            
            Spacer()
            
            Button(action: {
                authVM.logout()
            }) {
                Text("Logout")
                    .font(.headline)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.red)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding(.horizontal)
        }
        .sheet(isPresented: $showImagePicker) {
            ImagePicker(image: $selectedUIImage)
        }
//        .onChange(of: selectedUIImage) { newImage in
////            if let uiImage = newImage {
////                authVM.updateProfileImage(image: uiImage)
////            }
//        }
        .padding()
        .navigationTitle("Profile")
    }
}

extension DateFormatter {
    static let shortDate: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        return formatter
    }()
}


struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ProfileView()
                .environmentObject(AuthViewModel.mock)
        }
    }
}
