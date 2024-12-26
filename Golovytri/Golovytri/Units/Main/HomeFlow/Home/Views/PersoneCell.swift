//
//  PersoneCell.swift
//  Golovytri
//
//  Created by Andrii Momot on 26.12.2024.
//

import SwiftUI

struct PersoneCell: View {
    let person: Person
    
    @State private var image: Image?
    @State private var color = Color.greenCustom
    
    var body: some View {
        HStack(spacing: 14) {
            ZStack {
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
            }
            .frame(height: 54)
            
            VStack(alignment: .leading) {
                Text(person.name)
                    .font(Fonts.SFProDisplay.medium.swiftUIFont(size: 16))
                Text(person.date.toString(format: .ddMMyyyy))
                    .font(Fonts.SFProDisplay.lightItalic.swiftUIFont(size: 16))
            }
            .foregroundStyle(.darkBlue)
            
            Spacer()
            
            VStack {
                Text("\(person.days)d")
                    .font(Fonts.SFProDisplay.bold.swiftUIFont(size: 18))
                
                Text("\(person.budget)")
                    .font(Fonts.SFProDisplay.bold.swiftUIFont(size: 18))
            }
            .foregroundStyle(.darkBlue)
        }
        .onAppear {
            getColor()
            fetchImage(id: person.id)
        }
    }
}

private extension PersoneCell {
    func fetchImage(id: String) {
        Task {
            guard let data = await FileManagerService().fetchImage(with: id),
                  let uiImage = UIImage(data: data) else {
                return
            }
            let image = Image(uiImage: uiImage)
            
            DispatchQueue.main.async {
                withAnimation {
                    self.image = image
                }
            }
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
                withAnimation {
                    self.color = color
                }
            }
        }
    }
}

#Preview {
    PersoneCell(person: .init(
        name: "name",
        date: .init(),
        days: 12,
        budget: 3232,
        resources: "resources",
        priority: .high,
        description: "description")
    )
    .padding()
}
