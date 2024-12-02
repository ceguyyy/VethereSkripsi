//
//  Skrispi_VetHereApp.swift
//  Skrispi_VetHere
//
//  Created by Christian Gunawan on 05/11/24.
//
import SwiftUI

@main
struct VetClinicAppApp: App {
    @StateObject var authViewModel = AuthViewModel() // Initialize AuthViewModel
    
    var body: some Scene {
        WindowGroup {
            if authViewModel.isAuthenticated {
                ContentView(authViewModel: authViewModel)
            } else {
                if authViewModel.isLogin {
                    SignInView(authViewModel: authViewModel)
                } else {
                    SignUpView(authViewModel: authViewModel)
                }
            }
        }
    }
}
