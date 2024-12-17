//
//  TreeView.swift
//  Golovytri
//
//  Created by Andrii Momot on 17.12.2024.
//

import SwiftUI

struct TreeView: View {
    var people: [TreeItem]
    @State var priority: PersonPriority?
    
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
                                        priority: priority)
                    
                    
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
        .init(id: "8", priority: .high)
    ])
}
