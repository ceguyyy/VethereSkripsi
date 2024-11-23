//
//  ChooseScheduleView.swift
//  Skrispi_VetHere
//
//  Created by Christian Gunawan on 20/11/24.
//

import SwiftUI

struct ChooseScheduleView: View {
    var vet: VetModel?
    var pet: PetModel?
    var doctor: DoctorModel?
    @EnvironmentObject var router: Router
    @State private var selectedDate = Date()
    @State private var selectedTime = Date()

    var body: some View {
        VStack{
            List{
                Section{
                    DatePicker(
                        "Select a date and time",
                        selection: $selectedDate,
                        in: Date()...,
                        displayedComponents: [.date]
                    )
                    .datePickerStyle(GraphicalDatePickerStyle())
                    .padding()
                    
                    DatePicker("Time", selection: $selectedTime, displayedComponents: [.hourAndMinute])
                }
                
            }
            
            VStack {
                HStack {
                    HStack{
                        Text("Lanjutkan")
                        Spacer()
                        Image(systemName: "chevron.right")
                        
                    }
                    .padding()
                    .foregroundColor(.white)
                    .background(.blue)
                    .frame(maxWidth: .infinity)
                    .cornerRadius(8)
                      
                }
                .onTapGesture {
                    router.push(.noteview(Vet: vet!, Doctor: doctor!, Pet: pet!, selectedDate: selectedDate, selectedTime: selectedTime))
                }
                .padding(.horizontal)
            }
            
            
             
                    
            
        }
        .navigationTitle("Pilih Jadwal")
        .padding(.top, 10)
    }


    private var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter
    }
}

#Preview {
    ChooseScheduleView()
}
