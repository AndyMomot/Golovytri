//
//  PreloaderView.swift
//  Libarorent
//
//  Created by Andrii Momot on 06.10.2024.
//

import SwiftUI

struct PreloaderView: View {
    
    var onDidLoad: () -> Void
    
    @State private var timer: Timer?
    @State private var progress: Double = 0.0
    
    private var bounds: CGRect {
        UIScreen.main.bounds
    }
    
    var body: some View {
        ZStack {
            Color.white
                .ignoresSafeArea()
            
            Asset.logo.swiftUIImage
                .resizable()
                .scaledToFit()
                .padding(.horizontal, 46)
            
            VStack {
                Spacer()
                
                VStack(spacing: 15) {
                    Text("Načítání")
                        .foregroundStyle(.darkBlue)
                        .font(Fonts.SFProDisplay.bold.swiftUIFont(size: 25))
                        .multilineTextAlignment(.center)
                    
                    ProgressView(value: progress)
                        .tint(.greenCustom)
                }
            }
            .padding(.horizontal, 30)
            
        }
        .onAppear {
            startTimer()
        }
    }
}

private extension PreloaderView {
    func startTimer() {
        stopTimer()
        
        timer = .scheduledTimer(withTimeInterval: 0.01,
                                repeats: true, block: { timer in
            updateProgress(value: 0.005)
        })
    }
    
    func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
    
    func updateProgress(value: Double) {
        DispatchQueue.main.async {
            if progress + value > 1 {
                withAnimation {
                    progress = 1
                }
                stopTimer()
                onDidLoad()
            } else {
                withAnimation {
                    progress = progress + value
                }
            }
        }
    }
}

#Preview {
    PreloaderView {}
}
