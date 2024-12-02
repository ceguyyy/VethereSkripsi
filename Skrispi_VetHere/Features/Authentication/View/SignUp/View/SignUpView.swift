//
//  SignUpView.swift
//  Skrispi_VetHere
//
//  Created by Christian Gunawan on 13/11/24.
//

import SwiftUI

struct SignUpView: View {
    @ObservedObject var authVM: AuthViewModel
    var body: some View {
        NavigationView{
            VStack(alignment: .leading) {
                Spacer()
                Text("Nama")
                    .font(
                        Font.custom("SF Pro", size: 20)
                            .weight(.semibold)
                    )
                
                TextField("Masukan nama", text: $authVM.name)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                
                
                Text("Username")
                    .font(
                        Font.custom("SF Pro", size: 20)
                            .weight(.semibold)
                    )
                
                TextField("Masukan Username", text: $authVM.username)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                Text("Kata Sandi")
                    .font(
                        Font.custom("SF Pro", size: 20)
                            .weight(.semibold)
                    )
                SecureField("******", text: $authVM.password)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                if let errorMessage = authVM.errorMessage, !errorMessage.isEmpty {
                    Text(errorMessage).foregroundColor(.red)
                }
                Spacer()
                Button(action: {
                    authVM.signup()
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
                                authVM.isLogin = true
                                
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
    SignUpView(authVM: AuthViewModel())
}

