//
//  RootContentView.swift
//  Libarorent
//
//  Created by Andrii Momot on 06.10.2024.
//

import SwiftUI

struct RootContentView: View {
    @StateObject private var viewModel = RootContentViewModel()
    
    var body: some View {
        Group {
            if viewModel.showPreloader {
                PreloaderView {
                    DispatchQueue.main.async {
                        withAnimation {
                            self.viewModel.showPreloader = false
                        }
                    }
                }
            } else {
                switch viewModel.viewState {
                case .onboarding:
                    OnboardingViewTabView()
                        .environmentObject(viewModel)
                case .main:
                    TabBar()
                        .environmentObject(viewModel)
                }
            }
        }
        .onAppear {
            Task {
                viewModel.viewState = await viewModel.getFlow()
            }
        }
    }
}

#Preview {
    RootContentView()
}
