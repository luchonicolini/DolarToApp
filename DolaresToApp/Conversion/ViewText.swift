//
//  ViewText.swift
//  AppDolar
//
//  Created by Luciano Nicolini on 26/06/2024.
//

import SwiftUI

struct ViewText: View {
    let index: DolaresToApp.DolarDataModel
    let imagen: String
    let dollarValue: Double
    let convertToDollars: Bool
    private let horizontalPadding: CGFloat = 30
    
    private var compra: Double {
        return convertToDollars ? dollarValue * index.compra : dollarValue / index.compra
    }
    
    private var venta: Double {
        return convertToDollars ? dollarValue * index.venta : dollarValue / index.venta
    }
    
    var body: some View {
        VStack(spacing: 16) {
            HeaderView(title: "Dólar \(index.nombre)")
                .padding(.horizontal, horizontalPadding)
                .padding(.top, 20)
            
            CurrencyDetailView(imagen: imagen, label: convertToDollars ? "Compra" : "Compra", amount: compra)
                .padding(.horizontal, horizontalPadding)
            
            Divider()
                .background(Color.primary)
            
            CurrencyDetailView(imagen: imagen, label: convertToDollars ? "Venta" : "Venta", amount: venta)
                .padding(.horizontal, horizontalPadding)
            
            Divider()
                .background(Color.primary)
        }
        .padding()
        .background(Color(.color))
        .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
    }
}

struct HeaderView: View {
    let title: String
    
    var body: some View {
        HStack {
            Text(title)
                .font(.title)
                .fontWeight(.semibold)
                .foregroundStyle(.primary)
            
            Spacer()
        }
        .frame(maxWidth: .infinity)
    }
}

struct CurrencyDetailView: View {
    let imagen: String
    let label: String
    let amount: Double
    
    var body: some View {
        HStack {
            Image(imagen)
                .resizable()
                .frame(width: 50, height: 38)
                .clipShape(Circle())
                .overlay(Circle().stroke(Color.white, lineWidth: 1))
                .shadow(radius: 3)
            
            VStack(alignment: .leading) {
                Text(label)
                    .font(.title2)
                    .foregroundStyle(.primary)
                    .fontWeight(.medium)
                
                Text("$\(amount.formattedDecimalString(maximumFractionDigits: 2))")
                    .font(.title2)
                    .foregroundStyle(.primary)
                    .fontWeight(.semibold)
            }
            Spacer()
        }
        .frame(maxWidth: .infinity)
    }
}

extension Double {
    func formattedDecimalString(maximumFractionDigits: Int) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = maximumFractionDigits
        return formatter.string(from: NSNumber(value: self)) ?? "0"
    }
}

struct ViewText_Previews: PreviewProvider {
    static var previews: some View {
        let dataModel = DolarDataModel(
            compra: 94.0,
            venta: 100.0,
            casa: "Contado con liquidación",
            nombre: "Contado con liquidación", moneda: "",
            fechaActualizacion: "2023-03-18T02:36:00.000Z"
        )
        ViewText(index: dataModel, imagen: "usa", dollarValue: 1, convertToDollars: true)
    }
}
