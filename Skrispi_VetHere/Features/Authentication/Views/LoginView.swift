//
//  LoginView.swift
//  Skrispi_VetHere
//
//  Created by Christian Gunawan on 05/11/24.
//

import SwiftUI

struct LoginView: View {
    @ObservedObject var authVM: AuthViewModel
    @State private var navigateToSignUp = false
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                Spacer()
                Text("Username")
                    .font(
                    Font.custom("SF Pro", size: 20)
                    .weight(.semibold)
                    )
                TextField("Masukan username", text: $authVM.email)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .autocapitalization(.none)
                    .keyboardType(.emailAddress)
                    .padding(.bottom, 10)
                Text("Kata Sandi")
                    .font(
                    Font.custom("SF Pro", size: 20)
                    .weight(.semibold)
                    )
                
                SecureField("******", text: $authVM.password)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.bottom, 10)
                
                if let errorMessage = authVM.errorMessage {
                    if errorMessage != "User already exists"{
                        Text(errorMessage)
                            .foregroundColor(.red)
                            .padding(.bottom, 10)
                    }
                    
                }
                Spacer()
                Button(action: {
                    authVM.login()
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
                    authVM.isLogin = false
                }
                
            }
            .padding()
            .onChange(of: authVM.isAuthenticated) { _, isAuthenticated in
                if isAuthenticated {
                    navigateToSignUp = true
                }
            }
            .navigationTitle("Login")
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView(authVM: AuthViewModel())
    }
}
