//
//  HomeView.swift
//  DolarToApp
//
//  Created by Luciano Nicolini on 28/06/2024.
//

import SwiftUI

struct HomeView: View {
    @State private var networkManager = DolarNetworkManager()
    @AppStorage("dollars") private var storedDollars: String = ""
    
    let backgroundColor = Color(.background)
    let horizontalPadding: CGFloat = 20
    let verticalPadding: CGFloat = 10
    
    var body: some View {
        NavigationStack {
            ZStack(alignment: .top) {
                backgroundColor.ignoresSafeArea(.all)
                
                if networkManager.loading {
                    ProgressView()
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .background(Color(.systemBackground).opacity(0.7))
                        .progressViewStyle(CircularProgressViewStyle(tint: .primary))
                } else {
                    ScrollView(.vertical, showsIndicators: false) {
                        LazyVStack(spacing: 0) {
                            DateView(launcher: "DolarHoy")
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.top, 20)
                                .padding(.horizontal, horizontalPadding)
                            
                            Hashtags()
                                .padding()
                            
                            BannerView()
                                .frame(height: 60)
                                .cornerRadius(10)
                                .padding()
                            
                            Divider()
                                .padding(.horizontal, horizontalPadding)
                            
                            ForEach(networkManager.dolarData, id: \.self) { dolarData in
                                DollarView(index: dolarData)
                                    .frame(maxWidth: .infinity)
                                    .padding(verticalPadding)
                                    .scrollTransition { content, phase in
                                        content
                                            .scaleEffect(phase.isIdentity ? 1 : 0.75)
                                    }
                            }
                        }
                    }
                    .refreshable {
                        await refreshData()
                    }
                    .transition(.opacity)
                }
            }
            .onAppear {
                networkManager.fetchData()
            }
        }
        .navigationBarBackButtonHidden(true)
        .onDisappear {
            storedDollars = ""
        }
    }
    
    func refreshData() async {
        // Aquí llamamos a fetchData() de manera asíncrona
        await MainActor.run {
            networkManager.fetchData()
        }
    }
}

#Preview {
    HomeView()
}





