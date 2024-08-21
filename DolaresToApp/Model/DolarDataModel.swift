//
//  DolarDataModel.swift
//  DolaresToApp
//
//  Created by Luciano Nicolini on 28/06/2024.
//

import Foundation
import Combine

struct DolarDataModel: Decodable, Identifiable, Hashable {
    var id: String { nombre }
    var compra: Double
    var venta: Double
    var casa: String
    var nombre: String
    var moneda: String
    var fechaActualizacion: String
}
