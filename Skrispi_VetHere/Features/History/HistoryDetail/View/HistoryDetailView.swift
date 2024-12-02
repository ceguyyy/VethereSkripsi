//
//  HistoryView.swift
//  Skrispi_VetHere
//
//  Created by Christian Gunawan on 18/11/24.
//

import SwiftUI


struct HistoryDetailView: View {
    @EnvironmentObject var router: Router
    var appointment: AppointmentModel?
    var body: some View {
        NavigationView {
            VStack{
                Text("Ringkasan Pemesanan").font(
                    Font.custom("SF Pro", size: 22)
                    .weight(.bold)
                ).padding(.bottom,16)
                
                HStack{
                    Text("Tanggal").font(
                        Font.custom("SF Pro", size: 20)
                        .weight(.semibold)
                        )
                    Spacer()
                    Text("26 June 2024").font(Font.custom("SF Pro", size: 20)).padding()
                }
                HStack{
                    Text("Waktu").font(
                        Font.custom("SF Pro", size: 20)
                        .weight(.semibold)
                        )
                    Spacer()
                    Text("8:00Am").font(Font.custom("SF Pro", size: 20)).padding()
                }
                
                Divider()
                
                HStack{
                    Text("Nama Klinik").font(
                        Font.custom("SF Pro", size: 20)
                        .weight(.semibold)
                        )
                    Spacer()
                    Text("Klinik lorem").font(Font.custom("SF Pro", size: 20)).padding()
                }
                HStack{
                    Text("Nama Dokter").font(
                        Font.custom("SF Pro", size: 20)
                        .weight(.semibold)
                        )
                    Spacer()
                    Text("Dokter Lorem").font(Font.custom("SF Pro", size: 20)).padding()
                }
                
                HStack{
                    Text("Nama Hewan").font(
                        Font.custom("SF Pro", size: 20)
                        .weight(.semibold)
                        )
                    Spacer()
                    Text("Alpha").font(Font.custom("SF Pro", size: 20)).padding()
                }
                Divider()
                
                VStack(alignment: .leading){
                    Text("Catatan").font(
                        Font.custom("SF Pro", size: 20)
                        .weight(.semibold)
                    ).padding(.vertical, 10)
                    ScrollView{
                        Text("Keluhan Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec ultricies, lacus in sodales suscipit, odio magna consequat eros, non maximus neque orci at dolor. Fusce id nisi enim. Aliquam erat volutpat. Phasellus pellentesque tristique felis, ut suscipit sem tempus in. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia curae; Curabitur vel metus quis tortor placerat auctor. Fusce quis est a magna mattis iaculis. Nulla facilisi. Nam vestibulum, nunc at luctus porta, nisl erat malesuada ex, finibus semper justo sem quis dui. Vestibulum interdum ex viverra massa tempor imperdiet. Cras interdum suscipit varius. Donec facilisis, felis in viverra varius, risus ante tristique neque, sed auctor justo est vitae risus. Donec eget libero laoreet leo placerat condimentum. Nullam dui dui, euismod at blandit nec, bibendum sed augue. Mauris hendrerit, dui ut mattis volutpat, mauris augue auctor est, nec ultricies ligula massa ac dui. Sed imperdiet tincidunt fermentum.")
                    }
                   
                    
                }


                Spacer()
            }
            .padding()
              
        }

    }
}




#Preview {

    HistoryDetailView()
}
