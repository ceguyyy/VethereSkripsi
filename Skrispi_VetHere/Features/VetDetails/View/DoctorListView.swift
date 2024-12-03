//
//  DoctorListView.swift
//  Skrispi_VetHere
//
//  Created by Christian Gunawan on 03/12/24.
//


import SwiftUI

struct DoctorListView: View {
    var doctors: [DoctorModel]
    var bookingAction: (DoctorModel) -> Void
    var chatAction: () -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            ForEach(doctors, id: \.id) { doctor in
                DoctorCardComponentView(doctor: doctor, bookingAction: {
                    bookingAction(doctor)
                }, chatAction: chatAction)
            }
        }
    }
}
