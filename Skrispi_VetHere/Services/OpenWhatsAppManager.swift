//
//  File.swift
//  Skrispi_VetHere
//
//  Created by Christian Gunawan on 20/11/24.
//


import SwiftUI
import UIKit


func openWhatsAppManager(phoneNumber: String, message: String) {
    guard !phoneNumber.isEmpty else {
        print("Error: Phone number is empty.")
        return
    }

    let encodedMessage = message.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? message
    if let url = URL(string: "https://wa.me/\(phoneNumber)?text=\(encodedMessage)"), UIApplication.shared.canOpenURL(url) {
        UIApplication.shared.open(url)
    } else {
        print("Error: Unable to open WhatsApp.")
    }
}
