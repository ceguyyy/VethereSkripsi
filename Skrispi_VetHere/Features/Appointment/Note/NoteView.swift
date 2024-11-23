//
//  NoteView.swift
//  Skrispi_VetHere
//
//  Created by Christian Gunawan on 20/11/24.
//

import SwiftUI

struct NoteView: View {
    var vet: VetModel?
    var doctor: DoctorModel?
    var pet: PetModel?
    var selectedDate: Date?
    var selectedTime: Date?
    @State var notes: String = ""
    @EnvironmentObject var router: Router
    
    var body: some View {
        VStack{
            List{
                Section{
                    VStack(alignment: .leading) {
                        Text("Komplain dan penyakit Peliharaan")
                            .font(.headline)
                        Divider()
                        TextField("           Masukan catatan", text: $notes)
                            .frame(height: 360)
                            .background(Color.gray.opacity(0.1))
                            .cornerRadius(8)
                        
                    }
                }
                
            }
            VStack {
                HStack {
                    HStack{
                        Text("Lanjutkan")
                        Spacer()
                        Image(systemName: "chevron.right")
                    }
                    
                    .onTapGesture {
                        router.push(.summaryView(Vet: vet!, Doctor: doctor!, Pet: pet!, selectedDate: selectedDate!, selectedTime: selectedTime!, note: notes))
                    }
                    .padding()
                    .foregroundColor(.white)
                    .background(.blue)
                    .frame(maxWidth: .infinity)
                    .cornerRadius(8)
                    
                }
                .padding(.horizontal)
            }
        }
        .navigationTitle("Tambahkan Catatan")
        
    }
}

#Preview {
    NoteView()
}
