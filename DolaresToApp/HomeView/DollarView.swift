//
//  DollarView.swift
//  DolarToApp
//
//  Created by Luciano Nicolini on 28/06/2024.
//

import SwiftUI

struct DollarView: View {
    let horizontalPadding: CGFloat = 20
    let index: DolarDataModel
    
    // Paleta de colores personalizada
    let colorTable: [String: Color] = [
        "Oficial": .green,
        "Blue": .blue,
        "Bolsa": .gray,
        "Solidario (Turista)": .yellow,
        "Mayorista": .orange,
        "Contado con liquidación": .red,
    ]
    
    @State private var value1 = 0
    
    var body: some View {
        VStack(spacing: 16) {
            headerView()
                .padding(.horizontal, horizontalPadding)
                .padding(.top, 20)
            
            HStack(spacing: 8) {
                currencyDetailView(label: "Compra", value: index.compra)
                Divider()
                    .frame(width: 1, height: 50)
                    .background(Color.primary.opacity(0.6))
                currencyDetailView(label: "Venta", value: index.venta)
            }
            .padding(.horizontal, horizontalPadding)
            
            Divider()
                .background(Color.primary.opacity(0.6))
            
            if let formattedDate = formattedDate(from: index.fechaActualizacion) {
                Text("Última actualización: \(formattedDate)")
                    .font(.footnote)
                    .foregroundColor(.secondary)
                    .padding(.top, 10)
                    .padding(.horizontal, horizontalPadding)
            }
            
        }
        .padding()
        .background(.color)
        .cornerRadius(12)
        .shadow(color: Color.primary.opacity(0.10), radius: 3, x: 0, y: 3)
        .accessibilityElement(children: .contain)
        .accessibilityLabel("Dólar \(index.nombre)")
    }
    
    // Vista de encabezado mejorada
    @ViewBuilder
    private func headerView() -> some View {
        HStack {
            Image(systemName: "dollarsign.square.fill")
                .resizable()
                .frame(width: 40, height: 40)
                .foregroundColor(colorTable[index.nombre] ?? .gray)
                .symbolEffect(.pulse, value: value1)
                .onTapGesture {
                    value1 += 1
                }
                .padding(.trailing, 8)
            Text("Dólar \(index.nombre)")
                .font(.title)
                .fontWeight(.semibold)
                .foregroundStyle(.primary)
            Spacer()
        }
        .frame(maxWidth: .infinity)
    }
    
    // Vista de detalles de moneda mejorada y alineada
    @ViewBuilder
    private func currencyDetailView(label: String, value: Double?) -> some View {
        VStack(alignment: .center, spacing: 4) {
            Text(label)
                .font(.subheadline)
                .fontWeight(.medium)
                .foregroundColor(.primary)
            Text("$\(value ?? 0, specifier: "%.2f")")
                .font(.title2)
                .fontWeight(.bold)
                .foregroundStyle(.primary)
                .multilineTextAlignment(.center)
        }
        .frame(maxWidth: .infinity, alignment: .center)
        .accessibilityElement(children: .ignore)
               
    }
    
    // Formateo de fecha de actualización mejorado
    private func formattedDate(from dateString: String) -> String? {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        if let date = formatter.date(from: dateString) {
            formatter.dateStyle = .medium
            formatter.timeStyle = .short
            return formatter.string(from: date)
        }
        return nil
    }
}



struct DollarView_Previews: PreviewProvider {
    static var previews: some View {
        let dataModel = DolarDataModel(
            compra: 94.0,
            venta: 100.0,
            casa: "Contado con liquidación",
            nombre: "Contado con liquidación",
            moneda: "5",
            fechaActualizacion: "2023-03-18T02:36:00.000Z"
        )
        DollarView(index: dataModel)
    }
}

