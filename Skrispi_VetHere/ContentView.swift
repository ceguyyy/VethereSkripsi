//
//  ContentView.swift
//  Skrispi_VetHere
//
//  Created by Christian Gunawan on 05/11/24.
//

import SwiftUI
import Combine

struct ContentView: View {
    @ObservedObject var authVM: AuthViewModel
    @StateObject private var router = Router()
    
    var body: some View {
        NavigationStack(path: $router.path) {
            TabView {
                NavigationStack(path: $router.path) {
                    NearbyVetView(authVM: authVM)
                        .environmentObject(router)
                        .environmentObject(authVM)
                        .navigationDestination(for: Screen.self) { screen in
                            switch screen {
                            case .details(let vet):
                                DetailsView(vet: vet)
                                    .environmentObject(router)
                                    .environmentObject(authVM)
                            case .book(let vet, let doctor):
                                BookChoosePetView(petViewModel: MyPetViewModel(), vet: vet, doctor: doctor)
                                    .environmentObject(router)
                                    .environmentObject(authVM)
                            case .profile
                                : ProfileView()
                                    .environmentObject(router)
                                    .environmentObject(authVM)
                            case .chooseSchedule(let vet, let doctor, let pet):
                                ChooseScheduleView(vet: vet, pet: pet, doctor: doctor)   .environmentObject(router)
                                    .environmentObject(authVM)
                            case .noteview(let vet, let doctor, let pet, let selectedDate, let selectedTime):
                                NoteView(vet: vet, doctor: doctor, pet: pet, selectedDate: selectedDate, selectedTime: selectedTime)   .environmentObject(router)
                                    .environmentObject(authVM)
                            case .summaryView(let vet, let doctor, let pet, let selectedDate, let selectedTime, let note):
                                SummaryView(vet: vet, doctor: doctor, pet: pet, selectedDate: selectedDate, selectedTime: selectedTime, notes: note)
                                    .environmentObject(router)
                                    .environmentObject(authVM)
                            case .successBook:
                                SuccessBookView()
                                    .environmentObject(router)
                                    .environmentObject(authVM)
                            case .failedBook:
                                FailedBookView()
                                    .environmentObject(router)
                                    .environmentObject(authVM)
                            case .petDetail(let pet):
                                PetDetailView(pet: pet)
                                    .environmentObject(router)
                                    .environmentObject(authVM)
                            case .historyDetailView(let appointment):
                                HistoryDetailView(appointment: appointment)
                                    .environmentObject(router)
                                    .environmentObject(authVM)
                                
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
                    .environmentObject(authVM)
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
