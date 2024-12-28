//
//  SettingsView.swift
//  Golovytri
//
//  Created by Andrii Momot on 28.12.2024.
//

import SwiftUI

struct SettingsView: View {
    @StateObject private var viewModel = ViewModel()
    @EnvironmentObject private var rootViewModel: RootContentView.RootContentViewModel
    
    var body: some View {
        ZStack {
            Color.greenCustom
                .ignoresSafeArea()
            
            VStack(alignment: .leading, spacing: 20) {
                HStack {
                    Text("Nastavení")
                        .foregroundStyle(.white)
                        .font(Fonts.SFProDisplay.semibold.swiftUIFont(size: 25))
                    Spacer()
                }
                .padding()
                
                ZStack {
                    Asset.background.swiftUIImage
                        .resizable()
                    
                    ScrollView {
                        VStack(alignment: .leading, spacing: 20) {
                            SettingsButton(title: "Aktualizovat") { // update
                                onUpdateApp()
                            }
                            SettingsButton(title: "Podpora") { // support
                                viewModel.showSupport.toggle()
                            }
                            SettingsButton(title: "Vymažte data a ukončete") { // logout
                                viewModel.showAlert.toggle()
                            }
                        }
                    }
                    .scrollIndicators(.never)
                }
            }
        }
        .sheet(isPresented: $viewModel.showSupport) {
            SwiftUIViewWebView(url: viewModel.supportURL)
        }
        .alert("Vymažte data a ukončet", isPresented: $viewModel.showAlert) {
            Button("Zrušit", role: .cancel) {}
            Button("Potvrdit", role: .destructive) {
                viewModel.removeData()
                DispatchQueue.main.async {
                    rootViewModel.setFlow(.onboarding)
                }
            }
        } message: {
            Text("Opravdu chcete ukončit aplikaci a smazat všechna data?")
        }
    }
}

private extension SettingsView {
    func onUpdateApp() {
        guard let url = viewModel.appStoreURL,
              UIApplication.shared.canOpenURL(url)
        else { return }
        
        DispatchQueue.main.async {
            UIApplication.shared.open(url)
        }
    }
}

#Preview {
    SettingsView()
}
