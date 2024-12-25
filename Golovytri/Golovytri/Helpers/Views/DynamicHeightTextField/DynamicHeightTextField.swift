//
//  DynamicHeightTextField.swift

import SwiftUI

struct DynamicHeightTextField: View {
    var title: String
    var placeholder: String = "Napisz tekst"
    @Binding var text: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text(title)
                .foregroundStyle(.darkBlue)
                .font(Fonts.SFProDisplay.medium.swiftUIFont(size: 16))
                .lineLimit(1)
                .minimumScaleFactor(0.7)
            
            ZStack(alignment: .topLeading) {
                RoundedRectangle(cornerRadius: 8)
                    .foregroundStyle(.white)
                
                TextEditor(text: $text)
                    .foregroundStyle(.darkBlue)
                    .font(Fonts.SFProDisplay.medium.swiftUIFont(size: 16))
                    .padding()
                
                if text.isEmpty {
                    Text(placeholder)
                        .foregroundStyle(.darkBlue.opacity(0.5))
                        .font(Fonts.SFProDisplay.medium.swiftUIFont(size: 16))
                        .padding(.horizontal, 20)
                        .padding(.vertical, 26)
                        .allowsHitTesting(false)
                }
            }
            .background(.white)
            .cornerRadius(8, corners: .allCorners)
            .overlay {
                RoundedRectangle(cornerRadius: 8)
                    .stroke(.darkBlue, lineWidth: 1)
            }
        }
    }
}

#Preview {
    ZStack {
        Color.gray
        DynamicHeightTextField(
            title: "Uwaga do projektu",
            text: .constant(""))
        .frame(maxHeight: 117)
        .padding()
    }
}
