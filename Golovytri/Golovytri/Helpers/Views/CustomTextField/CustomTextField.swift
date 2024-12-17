//
//  CustomTextField.swift
//  Istnymdelay
//
//  Created by Andrii Momot on 02.12.2024.
//

import SwiftUI

struct CustomTextField: View {
    var title: String
    var placeholder: String = ""
    var isDynamic = false
    @Binding var text: String

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .font(Fonts.SFProDisplay.bold.swiftUIFont(size: 19))
                .foregroundStyle(.white)
            
            if isDynamic {
                ZStack(alignment: .topLeading) {
                    TextEditor(text: $text)
                        .scrollContentBackground(.hidden)
                        .font(Fonts.SFProDisplay.regular.swiftUIFont(size: 16))
                        .padding(.horizontal, 12)
                        .padding(.vertical, 16)
                    
                    
                    if text.isEmpty {
                        createPlaceholder(text: placeholder,
                                          isDynamic: isDynamic)
                    }
                }
                .background(.white)
                .cornerRadius(8, corners: .allCorners)
                .overlay {
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.gray.opacity(0.5), lineWidth: 1)
                }
                
            } else {
                TextField(text: $text) {
                    createPlaceholder(text: placeholder,
                                      isDynamic: isDynamic)
                }
                .font(Fonts.SFProDisplay.regular.swiftUIFont(size: 16))
                .foregroundStyle(.darkBlue)
                .padding(.horizontal, 12)
                .padding(.vertical, 16)
                .background(.white)
                .cornerRadius(8, corners: .allCorners)
                .overlay {
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.gray.opacity(0.5), lineWidth: 1)
                }
            }
        }
        .hideKeyboardWhenTappedAround()
    }
}

private extension CustomTextField {
    func createPlaceholder(text: String, isDynamic: Bool) -> some View {
        return Text(text)
            .font(Fonts.SFProDisplay.regular.swiftUIFont(size: 16))
            .foregroundStyle(.darkBlue.opacity(0.5))
            .padding(.horizontal, isDynamic ? 12 : 0)
            .padding(.vertical, isDynamic ? 27 : 0)
            .allowsHitTesting(false)
    }
}

#Preview {
    ZStack {
        Color.green
        ScrollView {
            VStack(spacing: 20) {
                CustomTextField(title: "Title",
                                placeholder: "placeholder",
                                text: .constant(""))
                
                CustomTextField(title: "Title",
                                placeholder: "placeholder",
                                isDynamic: true,
                                text: .constant(""))
            }
            .padding()
        }
    }
}
