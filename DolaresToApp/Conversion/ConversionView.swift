//
//  ConversionView.swift
//  AppDolar
//
//  Created by Luciano Nicolini on 26/06/2024.
//

import SwiftUI

struct ConversionView: View {
    @State private var dolarNetworkManager = DolarNetworkManager()
    let backgroundColor = Color(.color)
    let verticalPadding: CGFloat = 10
    let horizontalPadding: CGFloat = 20
    @State private var amount: Double = 0
    @State private var searchText: String = ""
    
    @AppStorage("dollars") var storedDollars: String = ""
    
    @State private var type2: Bool = false
    @State private var activeTab: SegmentedTab = .usdToArg
    
    var convertToDollars: Bool {
           return activeTab == .usdToArg
       }
    
    var body: some View {
        NavigationStack {
            ZStack(alignment: .top) {
                backgroundColor.ignoresSafeArea(.all)
                VStack(spacing: 0) {
                    CustomSegmented(activeTab: $activeTab)
                    Divider()
                    
                    ScrollView(.vertical, showsIndicators: false) {
                        
                        ForEach(dolarNetworkManager.dolarData) { index in
                            ViewText(index: index, imagen: convertToDollars ? "usa" : "argentina", dollarValue: amount, convertToDollars: convertToDollars)
                                .padding(verticalPadding)
                            
                            
                            
                        }
                        
                    }
                    .gesture(TapGesture().onEnded {
                        UIApplication.shared.endEditing()
                    })
                    .onAppear {
                        dolarNetworkManager.fetchData()
                    }
                    
                }
                .searchable(text: $searchText, prompt: "Ingrese monto")
                .keyboardType(.numberPad)
                .onChange(of: searchText) { oldValue,newValue in
                    if let newAmount = Double(newValue) {
                        amount = newAmount
                    } else {
                        amount = 0
                    }
                }
                .padding(.vertical, type2 ? 15 : 0)
                .animation(.snappy, value: type2)
                .navigationTitle("Conversion")
                .toolbarBackground(.hidden, for: .navigationBar)
            }
        }
    }
}


#Preview {
    ConversionView()
}

enum SegmentedTab: String, CaseIterable {
    case usdToArg = "USD a ARG"
    case argToUsd = "ARG a USD"
}


struct CustomSegmented: View {
    let backgroundColor = Color("Background")
    @Binding var activeTab: SegmentedTab
    @State private var type2: Bool = false
    
    var body: some View {
        CustomSegmentedControl(tabs: SegmentedTab.allCases, activeTab: $activeTab, height: 35, font: .subheadline, activeTint: type2 ? .white : .primary, inActivateTint: .gray.opacity(0.5)) { size in
            RoundedRectangle(cornerRadius: type2 ? 30 : 0)
                .fill(.blue)
                .frame(height: type2 ? size.height : 4)
                .padding(.horizontal, type2 ? 0 : 10)
                .frame(maxHeight: .infinity, alignment: .bottom)
        }
        .padding(.top, type2 ? 0 : 10)
        .background {
            RoundedRectangle(cornerRadius: type2 ? 30 : 0)
                .fill(Color(backgroundColor))
                .ignoresSafeArea()
        }
        .padding(.top, type2 ? 15 : 0)
        Spacer(minLength: 10)
    }
}


extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
