//
//  LoginView.swift
//  Skrispi_VetHere
//
//  Created by Christian Gunawan on 05/11/24.
//

import SwiftUI

struct SignInView: View {
    @ObservedObject var authViewModel: AuthViewModel
    @State private var navigateToSignUp: Bool = false
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                Spacer()
                Text("Username")
                    .font(
                    Font.custom("SF Pro", size: 20)
                    .weight(.semibold)
                    )
                TextField("Masukan username", text: $authViewModel.username)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .autocapitalization(.none)
                    .keyboardType(.emailAddress)
                    .padding(.bottom, 10)
                Text("Kata Sandi")
                    .font(
                    Font.custom("SF Pro", size: 20)
                    .weight(.semibold)
                    )
                
                SecureField("******", text: $authViewModel.password)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.bottom, 10)
                
                if let errorMessage = authViewModel.errorMessage {
                    if errorMessage != "User already exists"{
                        Text(errorMessage)
                            .foregroundColor(.red)
                            .padding(.bottom, 10)
                    }
                    
                }
                Spacer()
                Button(action: {
                    authViewModel.login()
                }) {
                    Text("Login")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.gray)
                        .foregroundColor(.black)
                        .cornerRadius(8)
                }
                .padding(.bottom, 10)
                VStack(alignment: .center){
                    HStack{
                        Spacer()
                        Text("Belum Punya Account? Registrasi")
                            .foregroundColor(.blue)
                            .padding(.top, 10)
                        Spacer()
                    }
                  
                }.onTapGesture {
                    authViewModel.isLogin = false
                }
                
            }
            .padding()
            
            .navigationTitle("Login")
        }
    }
}

#Preview {
    SignInView(authViewModel: AuthViewModel())
}
