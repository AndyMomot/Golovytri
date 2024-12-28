//
//  SettingsViewModel.swift
//  Golovytri
//
//  Created by Andrii Momot on 28.12.2024.
//

import Foundation

extension SettingsView {
    final class ViewModel: ObservableObject {
        let appStoreURL = URL(string: "https://www.apple.com")
        let supportURL = URL(string: "https://google.com")
        
        @Published var showSupport = false
        @Published var showAlert = false
        
        func removeData() {
            DispatchQueue.global().async {
                DefaultsService.shared.removeAll()
                FileManagerService().removeAllFiles()
            }
        }
    }
}
