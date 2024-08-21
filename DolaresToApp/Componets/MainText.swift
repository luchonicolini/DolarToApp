//
//  MainText.swift
//  AppDolar
//
//  Created by Luciano Nicolini on 26/06/2024.
//

import Foundation
import SwiftUI

struct DateView: View {
    var launcher: String
    @State private var date: String = ""
       
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(date)
                .font(.footnote)
                .fontWeight(.medium)
                .opacity(0.7)
            
            Text(launcher)
                .font(.largeTitle)
                .bold()
        }
        .onAppear() {
            date =
            Date.now.formatted(.dateTime.weekday().month().day().locale(Locale(identifier: "es-AR")))
           
        }
    }
}

struct SectionHeader: View {
    let text: String
    var backgroundColor: Color = .green
    var textColor: Color = .white
    
    var body: some View {
        GeometryReader { geometry in
            Text(text)
                .padding()
                .frame(width: geometry.size.width, height: 28, alignment: .leading)
                .background(backgroundColor)
                .foregroundColor(textColor)
        }
        .frame(height: 28)
        .accessibilityAddTraits(.isHeader)
    }
}

#Preview {
    DateView(launcher: "Novedades")
}
