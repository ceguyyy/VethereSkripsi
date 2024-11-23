//
//  to.swift
//  Skrispi_VetHere
//
//  Created by Christian Gunawan on 06/11/24.
//


import SwiftUI

class Router: ObservableObject {
    @Published var path: [Screen] = []

    func push(_ screen: Screen) {
        path.append(screen)
    }

    func pop() {
        guard !path.isEmpty else { return }
        path.removeLast()
    }

    func popToRoot() {
        path.removeAll()
    }
}






