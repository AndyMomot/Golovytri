//
//  SettingsButton.swift
//  Golovytri
//
//  Created by Andrii Momot on 28.12.2024.
//

import SwiftUI

struct SettingsButton: View {
    var title: String
    var action: () -> Void
    
    var body: some View {
        Button {
            action()
        } label: {
            HStack {
                Text(title)
                Spacer()
                Image(systemName: "chevron.right")
            }
            .foregroundStyle(.darkBlue)
            .font(Fonts.SFProDisplay.medium.swiftUIFont(size: 16))
            .padding(6)
        }
    }
}

#Preview {
    SettingsButton(title: "Update") {}
}
