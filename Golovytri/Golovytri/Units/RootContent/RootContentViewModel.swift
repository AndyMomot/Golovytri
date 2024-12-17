//
//  RootContentViewModel.swift
//  Libarorent
//
//  Created by Andrii Momot on 06.10.2024.
//

import Foundation

extension RootContentView {
    final class RootContentViewModel: ObservableObject {
        @Published var showPreloader = true
        
        @Published var viewState: ViewState = .onboarding
        
        func getFlow() async -> ViewState {
            let flow = DefaultsService.shared.flow
            return flow
        }
        
        func setFlow(_ flow: ViewState) {
            DispatchQueue.main.async { [weak self] in
                guard let self else { return }
                DefaultsService.shared.flow = flow
                DispatchQueue.main.async { [self] in
                    self.viewState = flow
                }
            }
        }
    }
}

extension RootContentView {
    enum ViewState: String {
        case onboarding
        case main
    }
}
