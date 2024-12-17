//
//  CircularProgressBar.swift
//
//  Created by Andrii Momot on 08.10.2024.
//

import SwiftUI

struct CircularProgressBar: View {
    var progress: Double
    var showProgress = false
    var trackColor: Color = .black
    var progressColor: Color = .red
    
    var lineWidth: CGFloat = 18
    var lineCap: CGLineCap = .butt
   
    
    var textColor: Color = .blue
    var font = Fonts.SFProDisplay.bold.swiftUIFont(size: 35)
    
    var body: some View {
        ZStack {
            Circle()
                .stroke( // 1
                    trackColor,
                    lineWidth: lineWidth
                )
            
            Circle()
                .trim(from: 0, to: progress)
                .stroke( // 1
                    progressColor,
                    style: .init(
                        lineWidth: lineWidth,
                        lineCap: lineCap
                    )
                )
                .rotationEffect(.degrees(-90))
                .animation(.easeOut, value: progress)
            
            if showProgress {
                Text((progress * 100).string() + "%")
                    .foregroundStyle(textColor)
                    .font(font)
                    .lineLimit(2)
                    .minimumScaleFactor(0.6)
            }
        }
        .padding(lineWidth / 2)
    }
}

#Preview {
    CircularProgressBar(progress: 0.2)
}
