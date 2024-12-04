//
//  SignUpView.swift
//  Skrispi_VetHere
//
//  Created by Christian Gunawan on 13/11/24.
//

import SwiftUI

struct SignUpView: View {
    @ObservedObject var authViewModel: AuthViewModel
    var body: some View {
        NavigationView{
            VStack(alignment: .leading) {
                Spacer()
                Text("Nama")
                    .font(
                        Font.custom("SF Pro", size: 20)
                            .weight(.semibold)
                    )
                
                TextField("Masukan nama", text: $authViewModel.name)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                
                
                Text("Username")
                    .font(
                        Font.custom("SF Pro", size: 20)
                            .weight(.semibold)
                    )
                
                TextField("Masukan Username", text: $authViewModel.username)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                Text("Kata Sandi")
                    .font(
                        Font.custom("SF Pro", size: 20)
                            .weight(.semibold)
                    )
                SecureField("******", text: $authViewModel.password)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                if let errorMessage = authViewModel.errorMessage, !errorMessage.isEmpty {
                    Text(errorMessage).foregroundColor(.red)
                }
                Spacer()
                Button(action: {
                    authViewModel.register()
                }) {
                    Text("Register")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.gray)
                        .foregroundColor(.black)
                        .cornerRadius(8)
                }
                .padding(.bottom, 10)
                VStack{
                    HStack{
                        Spacer()
                        Text("Sudah punya account? Login")
                            .foregroundColor(Color.blue).onTapGesture {
                                authViewModel.isLogin = true
                                
                            }
                        Spacer()
                        
                    }
                }
                
                .padding()
            }.navigationTitle("Register")
                .padding()
        }
        
    }
}

#Preview {
    SignUpView(authViewModel: AuthViewModel())
}

