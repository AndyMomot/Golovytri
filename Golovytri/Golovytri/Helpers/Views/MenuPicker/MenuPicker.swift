//
//  MenuPicker.swift
//  Golovytri
//
//  Created by Andrii Momot on 25.12.2024.
//

import SwiftUI

struct MenuPicker: View {
    let title: String
    let items: [String]
    @Binding var selection: String
    
    var body: some View {
        Menu {
            ForEach(items, id: \.self) { item in
                Button {
                    selection = item
                } label: {
                    Text(item)
                }
            }
        } label: {
            VStack(alignment: .leading, spacing: 10) {
                Text(title)
                    .foregroundStyle(.darkBlue)
                    .font(Fonts.SFProDisplay.medium.swiftUIFont(size: 16))
                    .lineLimit(1)
                    .minimumScaleFactor(0.7)
                
                HStack {
                    Text(selection)
                        .foregroundStyle(.darkBlue)
                        .font(Fonts.SFProDisplay.medium.swiftUIFont(size: 16))
                    
                    Spacer()
                    
                    Image(systemName: "chevron.down")
                }
                .padding(18)
                .background(.white)
                .cornerRadius(8, corners: .allCorners)
                .overlay {
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(.darkBlue, lineWidth: 1)
                }
            }
        }
    }
}

#Preview {
    MenuPicker(
        title: "Title",
        items: [
            "Item 1", "Item 2", "Item 3"
        ], selection: .constant("Item 1"))
    .padding()
}
