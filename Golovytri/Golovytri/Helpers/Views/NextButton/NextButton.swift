//
//  NextButton.swift
//
//  Created by Andrii Momot on 08.10.2024.
//

import SwiftUI

struct NextButton: View {
    var title: String
    var borders = false
    var action: () -> Void
    
    var body: some View {
        Button {
            action()
        } label: {
            ZStack {
                Rectangle()
                    .fill(.white)
                    .cornerRadius(20, corners: [.bottomLeft, .bottomRight])
                    .hidden(!borders)
                
                Group {
                    Rectangle()
                        .fill(Colors.greenCustom.swiftUIColor)
                        .cornerRadius(20, corners: [.bottomLeft, .bottomRight])
                    
                    Text(title)
                        .foregroundStyle(.white)
                        .font(Fonts.SFProDisplay.bold.swiftUIFont(size: 20))
                        .multilineTextAlignment(.center)
                        .minimumScaleFactor(0.8)
                        .padding(.horizontal, 8)
                }
                .padding(borders ? 3 : 0)
                
            }
            .cornerRadius(20, corners: [.bottomLeft, .bottomRight])
        }
    }
}

#Preview {
    ZStack {
        Color.gray
        
        VStack {
            NextButton(title: "Další") {}
                .frame(height: 52)
                .padding(.horizontal)
            
            NextButton(title: "Další", borders: true) {}
                .frame(height: 52)
                .padding(.horizontal)
        }
    }
}
