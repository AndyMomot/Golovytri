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
        @Published var selection = TabBarSelectionView.list.rawValue
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
        case list = 0
        case timer
        case statistics
    }
    
    struct Item: Identifiable {
        private(set) var id = UUID()
        var imageName: String
        var title: String
    }
}
