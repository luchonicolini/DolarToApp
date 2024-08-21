//
//  Hashtags.swift
//  AppDolar
//
//  Created by Luciano Nicolini on 26/06/2024.
//

import Foundation
import SwiftUI

struct Hashtags: View {
    var body: some View {
        textWithHashtags("Aquí podrás estar al tanto de la #cotización del dólar en Argentina y realizar un seguimiento de su evolución.", color: .blue)
            .font(.system(size: 23,weight: .medium,design: .rounded))
            .bold()
           
    }
}

func textWithHashtags(_ text: String, color: Color) -> Text {
    let words = text.split(separator: " ")
    var output: Text = Text("")

    for word in words {
        if word.hasPrefix("#") { // Pick out hash in words
            output = output + Text(" ") + Text(String(word))
                .foregroundColor(color) // Add custom styling here
        } else {
            output = output + Text(" ") + Text(String(word))
        }
    }
    return output
}
