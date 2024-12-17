//
//  BackButton.swift
//  Libarorent
//
//  Created by Andrii Momot on 07.10.2024.
//

import SwiftUI

struct BackButton: View {
    var title: String
    var canDismiss = true
    var action: (() -> Void)?
    
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        HStack(spacing: 25) {
            if canDismiss {
                Button {
                    action?()
                    dismiss.callAsFunction()
                } label: {
                    Image(systemName: "chevron.left")
                }
            }
            
            Text(title)
                .lineLimit(2)
                .minimumScaleFactor(0.6)
            
            Spacer()
        }
        .foregroundStyle(.white)
        .font(Fonts.SFProDisplay.bold.swiftUIFont(size: 28))
        .navigationBarBackButtonHidden()
    }
}

#Preview {
    ZStack {
        Color.green
        VStack(spacing: 20) {
            BackButton(title: "Telefony") {}
            BackButton(title: "Telefony") {}
        }
    }
}
