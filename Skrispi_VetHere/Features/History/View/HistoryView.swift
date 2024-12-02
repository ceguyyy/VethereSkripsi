//
//  HistoryView.swift
//  Skrispi_VetHere
//
//  Created by Christian Gunawan on 18/11/24.
//

import SwiftUI


struct HistoryView:View {
    @EnvironmentObject var router: Router
    var appointment: AppointmentModel?
    var body: some View {
        NavigationView {
            List{
                HStack {
                    Image(systemName: "person.circle.fill")
                        .resizable()
                        .frame(width: 40, height: 40)
                    VStack(alignment: .leading){
                        Text("/(namaKlinik) - /(namaDokter)")
                        Text("/(PetName) = /(dd:mm:yyyy/hh:mm)").font(.caption)
                    }
                    Spacer()
                    Image(systemName: "chevron.right").opacity(0.2)
                }.onTapGesture {
                    router.push(.historyDetailView(appointment: AppointmentModel(appointmentID: UUID(), vetID: UUID(), doctorID: UUID(), userID: UUID(), petID: UUID(), appointmentNote: "", appointmentDate: Date.now, appointmentTime: Date.now)))
                }
            }.navigationTitle("Riwayat")
                .toolbar{
                    ToolbarItem(placement: .navigationBarTrailing){
                        Button(action: {
                            router.push(.profile)
                        }) {
                            Image(systemName: "person.fill") //

                        }
                    }
                }
        }

    }
}





#Preview {
    let sampleAppointMent = AppointmentModel(appointmentID: UUID(), vetID: UUID(), doctorID: UUID(), userID: UUID(), petID: UUID(), appointmentNote: "Notes", appointmentDate: .now, appointmentTime: .now)
    HistoryView(appointment: sampleAppointMent)
}
