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
            Text(date.uppercased())
                .font(.footnote)
                .fontWeight(.medium)
                .opacity(0.7)
            
            Text(launcher)
                .font(.largeTitle).bold()
        }
        .onAppear() {
            date =
            Date.now.formatted(.dateTime.weekday().month().day().locale(Locale(identifier: "es-AR")))
           
        }
    }
}

struct SectionHeader: View {
    let text: String
    var body: some View {
        Text(text)
            .padding()
            .frame(width: UIScreen.main.bounds.width, height: 28,alignment: .leading)
            .background(Color.green)
            .foregroundColor(Color.white)
    }
}

#Preview {
    DateView(launcher: "Novedades")
}
