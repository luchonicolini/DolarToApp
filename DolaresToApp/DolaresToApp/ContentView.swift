//
//  ContentView.swift
//  DolaresToApp
//
//  Created by Luciano Nicolini on 28/06/2024.
//

import SwiftUI

struct ContentView: View {
    @State private var showLauncher: Bool = true
    @State private var animationDuration: Double = 0.5
    
    var body: some View {
        ZStack {
            if showLauncher {
                LauncherView()
                    .transition(.opacity)
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                            withAnimation(.easeInOut(duration: animationDuration)) {
                                self.showLauncher = false
                            }
                        }
                    }
            } else {
                TabView {
                    HomeView()
                        .tabItem {
                            Label("Home", systemImage: "dollarsign.circle")
                        }
                    
                    ConversionView()
                        .tabItem {
                            Label("Conversiones", systemImage: "arrow.triangle.2.circlepath")
                        }
                }
                .accentColor(.primary)
            }
        }
        .animation(.default, value: showLauncher)
    }
}

#Preview {
    ContentView()
}
