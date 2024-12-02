//
//  Skrispi_VetHereApp.swift
//  Skrispi_VetHere
//
//  Created by Christian Gunawan on 05/11/24.
//
import SwiftUI

@main
struct VetClinicAppApp: App {
    @StateObject var authVM = AuthViewModel() // Initialize AuthViewModel
    
    var body: some Scene {
        WindowGroup {
            if authVM.isAuthenticated {
                ContentView(authVM: authVM)
            } else {
                if authVM.isLogin {
                    LoginView(authVM: authVM)
                } else {
                    SignUpView(authVM: authVM)
                }
            }
        }
    }
}
