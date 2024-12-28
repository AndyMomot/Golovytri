//
//  PersoneCell.swift
//  Golovytri
//
//  Created by Andrii Momot on 26.12.2024.
//

import SwiftUI

struct PersonCell: View {
    let person: Person
    var canEdit = false
    var showLoading = false
    
    var action: ((ViewAction) -> Void)?
    
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
            .frame(height: canEdit ? 30 : 54)
            
            VStack(alignment: .leading) {
                Text(person.name)
                    .font(Fonts.SFProDisplay.medium.swiftUIFont(size: canEdit ? 12 : 16))
                Text(person.date.toString(format: .ddMMyyyy))
                    .font(Fonts.SFProDisplay.lightItalic.swiftUIFont(size: canEdit ? 12 : 16))
            }
            .foregroundStyle(.darkBlue)
            
            Spacer()
            
            ZStack {
                VStack {
                    HStack {
                        if canEdit {
                            Button {
                                action?(.minusDay)
                            } label: {
                                Image(systemName: "minus")
                                    .resizable()
                                    .frame(width: 6, height: 2)
                                    .foregroundStyle(.white)
                                    .padding(.vertical, 10)
                                    .padding(.horizontal, 8)
                                    .background(.greenCustom)
                                    .cornerRadius(3, corners: .allCorners)
                            }
                        }
                        
                        Text("\(person.days)d")
                            .font(Fonts.SFProDisplay.bold.swiftUIFont(size: 18))
                        
                        if canEdit {
                            Button {
                                action?(.plusDay)
                            } label: {
                                Image(systemName: "plus")
                                    .resizable()
                                    .frame(width: 10, height: 10)
                                    .foregroundStyle(.white)
                                    .padding(6)
                                    .background(.greenCustom)
                                    .cornerRadius(3, corners: .allCorners)
                            }
                        }
                    }
                    
                    HStack {
                        if canEdit {
                            Button {
                                action?(.minusBudget)
                            } label: {
                                Image(systemName: "minus")
                                    .resizable()
                                    .frame(width: 6, height: 2)
                                    .foregroundStyle(.white)
                                    .padding(.vertical, 10)
                                    .padding(.horizontal, 8)
                                    .background(.greenCustom)
                                    .cornerRadius(3, corners: .allCorners)
                            }
                        }
                        
                        Text("\(person.budget)")
                            .font(Fonts.SFProDisplay.bold.swiftUIFont(size: 18))
                        
                        if canEdit {
                            Button {
                                action?(.plusBudget)
                            } label: {
                                Image(systemName: "plus")
                                    .resizable()
                                    .frame(width: 10, height: 10)
                                    .foregroundStyle(.white)
                                    .padding(6)
                                    .background(.greenCustom)
                                    .cornerRadius(3, corners: .allCorners)
                            }
                        }
                    }
                }
                .foregroundStyle(.darkBlue)
                .multilineTextAlignment(.center)
                .disabled(showLoading)
                .opacity(showLoading ? 0.5 : 1)
                
                if showLoading {
                    ProgressView()
                }
            }
        }
        .onAppear {
            getColor()
            fetchImage(id: person.id)
        }
    }
}

extension PersonCell {
    enum ViewAction {
        case minusDay
        case plusDay
        case minusBudget
        case plusBudget
    }
}

private extension PersonCell {
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
    VStack {
        PersonCell(person: .init(
            name: "name",
            date: .init(),
            days: 12,
            budget: 3232,
            resources: "resources",
            priority: .high,
            description: "description")
        )
        
        PersonCell(person: .init(
            name: "name",
            date: .init(),
            days: 12,
            budget: 3232,
            resources: "resources",
            priority: .high,
            description: "description"),
                    canEdit: true
        )
        
        PersonCell(person: .init(
            name: "name",
            date: .init(),
            days: 12,
            budget: 3232,
            resources: "resources",
            priority: .high,
            description: "description"),
                    canEdit: true,
                   showLoading: true
        )
    }
    .padding()
}
