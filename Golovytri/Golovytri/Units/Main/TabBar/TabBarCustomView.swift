//
//  TabBarCustomView.swift
//  Goobeltoin
//
//  Created by Andrii Momot on 13.06.2024.
//

import SwiftUI

struct TabBarCustomView: View {
    @Binding var selectedItem: Int
    
    private let items: [TabBar.Item] = [
        .init(imageName: Asset.tab1.name, title: "Strom"),
        .init(imageName: Asset.tab2.name, title: "Kalkulačka"),
        .init(imageName: Asset.tab3.name, title: "Statistiky"),
        .init(imageName: Asset.tab5.name, title: "Strom")
    ]
    
    private var arrange: [Int] {
        Array(0..<items.count)
    }
    
    private var bounds: CGRect {
        UIScreen.main.bounds
    }
    
    var body: some View {
        let arrange = (0..<items.count)
        
        HStack(spacing: 0) {
            Spacer()
            ForEach(arrange, id: \.self) { index in
                let item = items[index]
                let isSelected = index == selectedItem
                
                VStack(spacing: 5) {
                    Image(item.imageName)
                        .renderingMode(.template)
                        .resizable()
                        .scaledToFit()
                        .foregroundStyle(isSelected ? .white : .darkBlue)
                        .frame(minWidth: 30)
                    
                    if isSelected {
                        Text(item.title)
                            .foregroundStyle(isSelected ? .white : .green)
                            .font(Fonts.SFProDisplay.bold.swiftUIFont(size: 16))
                            .multilineTextAlignment(.center)
                            .lineLimit(1)
                            .minimumScaleFactor(0.8)
                    }
                }
                .onTapGesture {
                    withAnimation(.easeInOut(duration: 0.3)) {
                        selectedItem = index
                    }
                }
                
                Spacer()
            }
        }
        .padding(23)
        .background(Colors.greenCustom.swiftUIColor)
    }
}

struct TabBarCustomView_Previews: PreviewProvider {
    static var previews: some View {
        TabBarCustomView(selectedItem: .constant(0))
            .previewLayout(.sizeThatFits)
    }
}
