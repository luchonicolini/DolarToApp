//
//  CustomTabBar.swift
//  DolaresToApp
//
//  Created by Luciano Nicolini on 01/07/2024.
//

import Foundation
import SwiftUI

enum Tab: String, CaseIterable {
    case home = "house"
    case conversion = "arrow.triangle.2.circlepath.circle"

}

struct CustomTabBar: View {
    @Binding var selectedTab: Tab
    private var fillImage: String {
        selectedTab.rawValue + ".fill"
    }
    private var tabColor: Color {
        switch selectedTab {
        case .home:
            return .primary
        case .conversion:
            return .primary

        }
    }
    
    
    var body: some View {
        VStack {
            HStack {
                ForEach(Tab.allCases, id: \.rawValue) { tab in
                    Spacer()
                    Image(systemName: selectedTab == tab ? fillImage : tab.rawValue)
                        .scaleEffect(tab == selectedTab ? 1.2 : 1.0)
                        .foregroundColor(tab == selectedTab ? tabColor : .gray)
                        .font(.system(size: 20))
                        .onTapGesture {
                            withAnimation(.easeInOut(duration: 0.2)) {
                                selectedTab = tab
                            }
                        }
                    Spacer()
                }
            }
            .frame(width: nil, height: 50)
            .background(.thinMaterial)
            .cornerRadius(10)
            .padding()
        }
    }
}


#Preview {
    CustomTabBar(selectedTab: .constant(.home))
}
