//
//  TreeView.swift
//  Golovytri
//
//  Created by Andrii Momot on 17.12.2024.
//

import SwiftUI

struct TreeView: View {
    var people: [TreeItem]
    @Binding var priority: PersonPriority?
    
    var onSelect: (TreeItem) -> Void
    
    var body: some View {
        ZStack {
            VStack {
                Spacer()
                Rectangle()
                    .fill(.greenCustom)
                    .frame(height: 70)
            }
            
            VStack {
                Spacer()
                ZStack {
                    Asset.tree.swiftUIImage
                        .resizable()
                        .scaledToFit()
                    
                    InvertedPyramidView(people: people,
                                        priority: priority,
                                        onSelect: onSelect)
                }
                .overlay {
                    VStack {
                        HStack {
                            Spacer()
                            TreePriorityPicker(selectedPriority: $priority)
                        }
                        Spacer()
                    }
                }
            }
            .padding(.bottom)
        }
    }
}

#Preview {
    TreeView(people: [
        .init(id: "0", priority: .low),
        .init(id: "1", priority: .medium),
        .init(id: "2", priority: .high),
        
            .init(id: "3", priority: .low),
        .init(id: "4", priority: .medium),
        .init(id: "5", priority: .high),
        
            .init(id: "6", priority: .low),
        .init(id: "7", priority: .medium),
        .init(id: "8", priority: .high),
        
            .init(id: "9", priority: .low),
        .init(id: "10", priority: .medium),
        .init(id: "11", priority: .high),
        
            .init(id: "12", priority: .low),
        .init(id: "13", priority: .medium),
        .init(id: "14", priority: .high),
        
            .init(id: "15", priority: .low),
        .init(id: "16", priority: .medium),
        .init(id: "17", priority: .high),
        
            .init(id: "18", priority: .low),
        .init(id: "19", priority: .medium),
        .init(id: "20", priority: .high),
        
            .init(id: "21", priority: .low),
        .init(id: "22", priority: .medium),
        .init(id: "23", priority: .high),
    ], priority: .constant(nil)) {_ in}
}
