//
//  TreeCell.swift
//  Golovytri
//
//  Created by Andrii Momot on 17.12.2024.
//

import SwiftUI

struct TreeCell: View {
    var person: TreeItem
    
    @State private var image: Image?
    @State private var color = Color.greenCustom
    
    var body: some View {
        Circle()
            .fill(color)
            .overlay {
                if let image {
                    image
                        .resizable()
                        .scaledToFill()
                        .clipShape(Circle())
                        .padding(2)
                    
                } else {
                    Image(systemName: "questionmark")
                        .resizable()
                        .scaledToFit()
                        .foregroundStyle(.white)
                        .padding()
                }
            }
            .onAppear {
                getColor()
                Task {
                    await getImage()
                }
            }
    }
}

private extension TreeCell {
    func getImage() async {
        guard let imageData = await FileManagerService().fetchImage(with: person.id),
              let uiImage = UIImage(data: imageData)
        else {
            withAnimation {
                image = nil
            }
            return
        }
        withAnimation {
            image = Image(uiImage: uiImage)
        }
    }
    
    func getColor() {
        DispatchQueue.global().async {
            var color: Color {
                switch person.priority {
                case .low:
                    return .greenCustom
                case .medium:
                    return .orangeCustom
                case .high:
                    return .redCustom
                }
            }
            
            DispatchQueue.main.async {
                self.color = color
            }
        }
    }
}

#Preview {
    VStack(spacing: 20) {
        TreeCell(person: .init(
            id: "0",
            priority: .low
        ))
        
        TreeCell(person: .init(
            id: "1",
            priority: .medium
        ))
        
        TreeCell(person: .init(
            id: "2",
            priority: .high
        ))
    }
    .padding()
}
