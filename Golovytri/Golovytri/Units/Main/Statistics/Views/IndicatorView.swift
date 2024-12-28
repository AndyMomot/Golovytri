//
//  IndicatorView.swift
//  Golovytri
//
//  Created by Andrii Momot on 28.12.2024.
//

import SwiftUI

struct IndicatorView: View {
    var body: some View {
        HStack {
            HStack(spacing: 5) {
                Circle()
                    .fill(.redCustom)
                    .frame(width: 10)
                Text("Vysoká")
                    .foregroundStyle(.darkBlue)
                    .font(Fonts.SFProDisplay.bold.swiftUIFont(size: 16))
            }
            
            Spacer()
            
            HStack(spacing: 5) {
                Circle()
                    .fill(.orangeCustom)
                    .frame(width: 10)
                Text("Střední")
                    .foregroundStyle(.darkBlue)
                    .font(Fonts.SFProDisplay.bold.swiftUIFont(size: 16))
            }
            
            Spacer()
            
            HStack(spacing: 5) {
                Circle()
                    .fill(.greenCustom)
                    .frame(width: 10)
                Text("Nízká")
                    .foregroundStyle(.darkBlue)
                    .font(Fonts.SFProDisplay.bold.swiftUIFont(size: 16))
            }
        }
    }
}

#Preview {
    IndicatorView()
}
