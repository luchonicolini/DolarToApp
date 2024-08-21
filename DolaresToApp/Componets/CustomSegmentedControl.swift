//
//  CustomSegmentedControl.swift
//  AppDolar
//
//  Created by Luciano Nicolini on 26/06/2024.
//

import Foundation
import SwiftUI

struct CustomSegmentedControl<Indicator: View>: View {
    var tabs: [SegmentedTab]
    @Binding var activeTab: SegmentedTab
    var height: CGFloat = 45
    var font: Font = .title3
    var activeTint: Color
    var inActivateTint: Color
    @ViewBuilder var indicatorView: (CGSize) -> Indicator
    
    @State private var excessTabWidth: CGFloat = .zero
    @State private var minX: CGFloat = .zero
    
    var body: some View {
        GeometryReader { geometry in
            let containerWidthForEachTab = geometry.size.width / CGFloat(tabs.count)
            
            HStack(spacing: 0) {
                ForEach(tabs, id: \.self) { tab in
                    Text(tab.rawValue)
                        .font(font)
                        .fontWeight(.semibold)
                        .foregroundStyle(activeTab == tab ? activeTint : inActivateTint)
                        .animation(.snappy, value: activeTab)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .contentShape(Rectangle())
                        .onTapGesture {
                            if let index = tabs.firstIndex(of: tab), let activeIndex = tabs.firstIndex(of: activeTab) {
                                activeTab = tab
                                
                                withAnimation(.snappy(duration: 0.25, extraBounce: 0)) {
                                    excessTabWidth = containerWidthForEachTab * CGFloat(index - activeIndex)
                                }
                                
                                withAnimation(.snappy(duration: 0.25, extraBounce: 0)) {
                                    minX = containerWidthForEachTab * CGFloat(index)
                                    excessTabWidth = 0
                                }
                            }
                        }
                        .background(alignment: .leading) {
                            if tabs.first == tab {
                                GeometryReader { proxy in
                                    let size = proxy.size
                                    
                                    indicatorView(size)
                                        .frame(width: size.width + (excessTabWidth < 0 ? -excessTabWidth : excessTabWidth), height: size.height)
                                        .frame(width: size.width, alignment: excessTabWidth < 0 ? .trailing : .leading)
                                        .offset(x: minX)
                                }
                            }
                        }
                }
            }
            .preference(key: SizeKey.self, value: geometry.size)
            .onPreferenceChange(SizeKey.self) { size in
                if let index = tabs.firstIndex(of: activeTab) {
                    minX = containerWidthForEachTab * CGFloat(index)
                    excessTabWidth = 0
                }
            }
        }
        .frame(height: height)
    }
}

fileprivate struct SizeKey: PreferenceKey {
    static var defaultValue: CGSize = .zero
    static func reduce(value: inout CGSize, nextValue: () -> CGSize) {
        value = nextValue()
    }
}
