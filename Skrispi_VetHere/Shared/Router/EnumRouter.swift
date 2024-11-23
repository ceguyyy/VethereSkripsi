//
//  Screen.swift
//  Skrispi_VetHere
//
//  Created by Christian Gunawan on 06/11/24.
//


import SwiftUI


enum Screen:Hashable{
    
    case home
    case details(vet: VetModel)
    case book(vet: VetModel, doctor: DoctorModel)
    case profile
    case history
    case chat
    case myPet
    case login
    case signup
    case chooseSchedule(vet: VetModel, doctor: DoctorModel, pet: PetModel)
    case noteview(Vet: VetModel, Doctor: DoctorModel, Pet: PetModel, selectedDate: Date, selectedTime: Date)
    case summaryView(Vet: VetModel, Doctor: DoctorModel, Pet: PetModel, selectedDate: Date, selectedTime: Date, note: String)
    case successBook
    case failedBook
    case petDetail(pet: PetModel)
    case historyDetailView(appointment: AppointmentModel)
    
    var id: UUID { UUID() }
}


