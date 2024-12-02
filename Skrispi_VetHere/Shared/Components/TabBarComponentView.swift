//
//  ContentView.swift
//  Skrispi_VetHere
//
//  Created by Christian Gunawan on 12/11/24.
//


import SwiftUI

struct TabBarComponentView: View {
    var body: some View {
        TabView {
            Text("Klinik")
                .tabItem {
                    Label("Klinik", systemImage: "house")
                }
                .tag(0)

            Text("Riwayat")
                .tabItem {
                    Label("Riwayat", systemImage: "clock")
                }
                .tag(1)

            Text("Peliharaan")
                .tabItem {
                    Label("Peliharaan", systemImage: "pawprint.fill")
                }
                .tag(3)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        TabBarComponentView()
    }
}
