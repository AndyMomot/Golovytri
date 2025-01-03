//
//  TabBar.swift
//  Goobeltoin
//
//  Created by Andrii Momot on 13.06.2024.
//

import SwiftUI

struct TabBar: View {
    @StateObject private var viewModel = TabBarViewModel()
    
    init() {
        UITabBar.appearance().isHidden = true
    }
    
    var body: some View {
        ZStack {
            Color.greenCustom
                .ignoresSafeArea()
            
            VStack(spacing: .zero) {
                TabView(selection: $viewModel.selection) {
                    HomeView()
                        .tag(TabBarSelectionView.tree.rawValue)
                    
                    CalculatorView()
                        .tag(TabBarSelectionView.calculator.rawValue)
                    
                    StatisticsView()
                        .tag(TabBarSelectionView.statistics.rawValue)
                    
                    SettingsView()
                        .tag(TabBarSelectionView.settings.rawValue)
                }
                
                Spacer()
                
                if viewModel.isShowTabBar {
                    TabBarCustomView(selectedItem: $viewModel.selection)
                        .frame(height: UIScreen.main.bounds.height * 0.12)
                }
            }
            .ignoresSafeArea(edges: .bottom)
        }
    }
}

#Preview {
    TabBar()
}
