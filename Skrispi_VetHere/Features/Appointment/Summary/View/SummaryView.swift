//
//  SummaryView.swift
//  Skrispi_VetHere
//
//  Created by Christian Gunawan on 20/11/24.
//

import SwiftUI

struct SummaryView: View {
    var vet: VetModel?
    var doctor: DoctorModel?
    var pet: PetModel?
    var selectedDate: Date?
    var selectedTime: Date?
    var notes: String?
    @EnvironmentObject var router: Router
    @EnvironmentObject var authVM: AuthViewModel
    var body: some View {
        VStack{
            
            List{
                Section{
                    VStack{
                        Text("Ringkasan Pemesanan").font(
                            Font.custom("SF Pro", size: 22)
                                .weight(.bold))
                        .padding(15)
                        HStack{
                            Text("Tanggal")
                                .font(
                                    Font.custom("SF Pro", size: 20)
                                        .weight(.semibold)
                                )
                                .foregroundColor(.black)
                            Spacer()
                            Text(selectedDate != nil ? formattedTimeDDMMYY(selectedDate!) : "-")
                                .font(Font.custom("SF Pro", size: 20))
                                .foregroundColor(.black)
                        }
                        .padding(4)
                        HStack{
                            Text("Waktu").font(
                                Font.custom("SF Pro", size: 20)
                                    .weight(.semibold)
                            )
                            .foregroundColor(.black)
                            Spacer()
                            Text(selectedTime != nil ? formattedTimeHHMM(selectedTime!) : "-")
                                    .font(Font.custom("SF Pro", size: 20))
                                    .foregroundColor(.black)
                        }
                        .padding(4)
                        Divider()
                        HStack{
                            Text("Nama Klinik").font(
                                Font.custom("SF Pro", size: 20)
                                    .weight(.semibold)
                            )
                            .foregroundColor(.black)
                            Spacer()
                            Text(vet?.name ?? "-").font(Font.custom("SF Pro", size: 20))
                                .foregroundColor(.black)
                            
                            
                            
                        }
                        .padding(4)
                        HStack{
                            if let user = authVM.currentUser {
                                Text("Owner").font(
                                    Font.custom("SF Pro", size: 20)
                                        .weight(.semibold))
                                Spacer()
                                Text("\(user.username)")
                                    .font(Font.custom("SF Pro", size: 20))
                                    .foregroundColor(.black)
                            }
                        }
                        
                        .padding(4)
                        HStack{
                            Text("Nama Dokter").font(
                                Font.custom("SF Pro", size: 20)
                                    .weight(.semibold)
                            )
                            .foregroundColor(.black)
                            Spacer()
                            Text(doctor?.DoctorName ?? "-").font(Font.custom("SF Pro", size: 20))
                                .foregroundColor(.black)
                        }
                        .padding(4)
                        HStack{
                            Text("Nama Hewan").font(
                                Font.custom("SF Pro", size: 20)
                                    .weight(.semibold)
                            )
                            .foregroundColor(.black)
                            Spacer()
                            Text(pet?.name ?? "-").font(Font.custom("SF Pro", size: 20))
                                .foregroundColor(.black)
                        }
                        .padding(4)
                        Divider()
                        HStack{
                            VStack(alignment: .leading){
                                Text("Catatan").font(Font.custom("SF Pro", size: 20))
                                    .foregroundColor(.black)
                                ScrollView{
                                    Text(notes ?? "No - Notes").font(Font.custom("SF Pro", size: 13))
                                        .foregroundColor(.black)
                                }
                                .frame(width: .infinity, height:124)
                                Spacer()
                            }
                        }
                        .padding(4)
                        
                    }
                }
            }
        }
        .navigationTitle("Ringkasan")
        
        
        VStack {
            HStack {
                HStack{
                    Text("Pesan")
                    Spacer()
                    Image(systemName: "chevron.right")
                }
                
                .onTapGesture {
                    router.push(.successBook)
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
    }

private func formattedTimeHHMM(_ date: Date) -> String {
    let formatter = DateFormatter()
    formatter.dateFormat = "HH:mm"
    return formatter.string(from: date)
}

private func formattedTimeDDMMYY(_ date: Date) -> String {
    let formatter = DateFormatter()
    formatter.dateFormat = "dd.MM.yyyy"
    return formatter.string(from: date)
}

#Preview {
    SummaryView()
}
