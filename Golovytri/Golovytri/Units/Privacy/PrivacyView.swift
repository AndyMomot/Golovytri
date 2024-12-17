//
//  PrivacyView.swift
//  Apeficonnect
//
//  Created by Andrii Momot on 17.11.2024.
//

import SwiftUI

struct PrivacyView: View {
    @EnvironmentObject private var rootViewModel: RootContentView.RootContentViewModel
    
    @State private var isAgreed = false
    @State var showPrivacyPolicy = false
    
    let privacyPolicyURL = URL(string: "https://google.com")
    
    var body: some View {
        ZStack {
            Color.white
                .ignoresSafeArea()
            
            VStack(spacing: 30) {
                Asset.privacyBg.swiftUIImage
                    .resizable()
                
                Group {
                    NextButton(title: "Vjezd") {
                        DispatchQueue.main.async {
                            rootViewModel.setFlow(.main)
                        }
                    }
                    .frame(height: 52)
                    .disabled(!isAgreed)
                    .opacity(isAgreed ? 1 : 0.7)
                    
                    HStack(spacing: 10) {
                        Button {
                            withAnimation {
                                isAgreed.toggle()
                            }
                        } label: {
                            ZStack {
                                RoundedRectangle(cornerRadius: 3)
                                    .stroke(.darkBlue, lineWidth: 2)
                                    .frame(width: 18, height: 18)
                                
                                Image(systemName: "checkmark")
                                    .resizable()
                                    .scaledToFit()
                                    .foregroundStyle(.darkBlue)
                                    .fontWeight(.bold)
                                    .frame(width: 12, height: 12)
                                    .opacity(isAgreed ? 1 : 0.3)
                            }
                        }
                        
                        Button {
                            DispatchQueue.main.async {
                                showPrivacyPolicy.toggle()
                            }
                        } label: {
                            Text("Souhlasím se zpracováním mých osobních údajů")
                                .foregroundStyle(.darkBlue)
                                .font(Fonts.SFProDisplay.medium.swiftUIFont(size: 16))
                                .multilineTextAlignment(.leading)
                                .underline()
                        }
                        
                        Spacer()
                    }
                }
                .padding(.horizontal, 27)
                
                Spacer()
            }
            .ignoresSafeArea(edges: .top)
            
            VStack {
                Asset.privacyLogo.swiftUIImage
                    .resizable()
                    .scaledToFit()
                    .padding(.horizontal, 27)
                Spacer()
            }
        }
        .sheet(isPresented: $showPrivacyPolicy) {
            SwiftUIViewWebView(url: privacyPolicyURL)
        }
    }
}

#Preview {
    PrivacyView()
}
