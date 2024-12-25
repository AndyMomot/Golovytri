//
//  TabBarViewModel.swift
//  Goobeltoin
//
//  Created by Andrii Momot on 13.06.2024.
//

import Foundation
import SwiftUI

extension TabBar {
    final class TabBarViewModel: ObservableObject {
        @Published var selection = TabBarSelectionView.tree.rawValue
        @Published var isShowTabBar = true
        
        func showTabBar(_ show: Bool) {
            DispatchQueue.main.async { [weak self] in
                self?.isShowTabBar = show
            }
        }
    }
}

extension TabBar {
    enum TabBarSelectionView: Int {
        case tree = 0
        case calculator
        case statistics
        case settings
    }
    
    struct Item: Identifiable {
        private(set) var id = UUID()
        var imageName: String
        var title: String
    }
}
