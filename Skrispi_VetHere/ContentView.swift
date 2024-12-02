//
//  ContentView.swift
//  Skrispi_VetHere
//
//  Created by Christian Gunawan on 05/11/24.
//

import SwiftUI
import Combine

struct ContentView: View {
    @ObservedObject var authViewModel: AuthViewModel
    @StateObject private var router = Router()
    
    var body: some View {
        NavigationStack(path: $router.path) {
            TabView {
                NavigationStack(path: $router.path) {
                    NearbyVetView(authViewModel: authViewModel)
                        .environmentObject(router)
                        .environmentObject(authViewModel)
                        .navigationDestination(for: Screen.self) { screen in
                            switch screen {
                            case .details(let vet):
                                DetailsView(vet: vet)
                                    .environmentObject(router)
                                    .environmentObject(authViewModel)
                            case .book(let vet, let doctor):
                                BookChoosePetView(petViewModel: MyPetViewModel(), vet: vet, doctor: doctor)
                                    .environmentObject(router)
                                    .environmentObject(authViewModel)
                            case .profile
                                : ProfileView()
                                    .environmentObject(router)
                                    .environmentObject(authViewModel)
                            case .chooseSchedule(let vet, let doctor, let pet):
                                ChooseScheduleView(vet: vet, pet: pet, doctor: doctor)   .environmentObject(router)
                                    .environmentObject(authViewModel)
                            case .noteview(let vet, let doctor, let pet, let selectedDate, let selectedTime):
                                NoteView(vet: vet, doctor: doctor, pet: pet, selectedDate: selectedDate, selectedTime: selectedTime)   .environmentObject(router)
                                    .environmentObject(authViewModel)
                            case .summaryView(let vet, let doctor, let pet, let selectedDate, let selectedTime, let note):
                                SummaryView(vet: vet, doctor: doctor, pet: pet, selectedDate: selectedDate, selectedTime: selectedTime, notes: note)
                                    .environmentObject(router)
                                    .environmentObject(authViewModel)
                            case .successBook:
                                SuccessBookView()
                                    .environmentObject(router)
                                    .environmentObject(authViewModel)
                            case .failedBook:
                                FailedBookView()
                                    .environmentObject(router)
                                    .environmentObject(authViewModel)
                            case .petDetail(let pet):
                                PetDetailView(pet: pet)
                                    .environmentObject(router)
                                    .environmentObject(authViewModel)
                            case .historyDetailView(let appointment):
                                HistoryDetailView(appointment: appointment)
                                    .environmentObject(router)
                                    .environmentObject(authViewModel)
                                
                            default:
                                EmptyView()
                            }
                        }
                }
                .tabItem {
                    Label("Klinik", systemImage: "house")
                }
                .tag(Screen.home)
                
                HistoryView()
                    .environmentObject(authViewModel)
                    .tabItem {
                        Label("Riwayat", systemImage: "clock")
                    }
                    .tag(Screen.history)
                
                
                
                MyPetView()
                    .tabItem {
                        Label("Peliharaan", systemImage: "pawprint.fill")
                    }
                    .tag(Screen.myPet)
            }
        }
        .environmentObject(router)
    }
}

//#Preview {
//    ContentView(authVM: <#AuthViewModel#>)
//}
