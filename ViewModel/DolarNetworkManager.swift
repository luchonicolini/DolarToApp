//
//  DolarNetworkManager.swift
//  DolarToApp
//
//  Created by Luciano Nicolini on 28/06/2024.
//


import SwiftUI
import Combine

@Observable
class DolarNetworkManager {
    var dolarData: [DolarDataModel] = []
    var loading = false
    var error: Error?
    
    private var cancellables = Set<AnyCancellable>()
    
    func updateDollarValues(_ value: Double) {
        dolarData.indices.forEach { index in
            let compra = dolarData[index].compra
            let venta = dolarData[index].venta
            
            dolarData[index].compra = compra * value
            dolarData[index].venta = venta * value
        }
    }
    
    func fetchData() {
        loading = true
        error = nil
        guard let url = URL(string: "https://dolar-api-argentina.vercel.app/v1/dolares") else {
            fatalError("Invalid URL")
        }
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: url) { [weak self] (data, response, error) in
            guard let self = self else { return }
            defer { DispatchQueue.main.async { self.loading = false } }
            if let error = error {
                DispatchQueue.main.async { self.error = error }
                return
            }
            guard let data = data else {
                DispatchQueue.main.async { self.error = NSError(domain: "DolarNetworkManager", code: 0, userInfo: [NSLocalizedDescriptionKey: "No data received"]) }
                return
            }
            Just(data)
                .decode(type: [DolarDataModel].self, decoder: JSONDecoder())
                .map { $0.filter { $0.nombre != "ContadoconLiqui" } }
                .receive(on: DispatchQueue.main)
                .sink(receiveCompletion: { completion in
                    if case let .failure(error) = completion {
                        self.error = error
                    }
                }, receiveValue: { value in
                    self.dolarData = value
                })
                .store(in: &self.cancellables)
        }
        task.resume()
    }
}
