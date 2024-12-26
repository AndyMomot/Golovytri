//
//  TreePriorityPicker.swift
//  Golovytri
//
//  Created by Andrii Momot on 17.12.2024.
//

import SwiftUI

struct TreePriorityPicker: View {
    @Binding var selectedPriority: PersonPriority?
    @State private var showOptions = false
    let priorities = PersonPriority.allCases
    
    var body: some View {
        HStack(spacing: 10) {
            Button {
                withAnimation {
                    showOptions.toggle()
                }
            } label: {
                Image(systemName: showOptions ? "chevron.right" : "chevron.left")
                    .resizable()
                    .scaledToFit()
                    .foregroundStyle(.greenCustom)
                    .frame(width: 12)
            }
            
            if showOptions {
                ForEach(priorities, id: \.rawValue) { priority in
                    let isSelected = selectedPriority == priority
                    Button {
                        didSelect(priority: priority)
                    } label: {
                        Circle()
                            .fill(getColor(for: priority))
                            .frame(width: 16)
                            .overlay {
                                if isSelected {
                                    Circle()
                                        .stroke(.darkBlue, lineWidth: 1)
                                }
                            }
                    }
                }
            }
        }
        .padding(.horizontal, 10)
        .padding(.vertical, 3)
        .overlay {
            RoundedRectangle(cornerRadius: 10)
                .stroke(.greenCustom, lineWidth: 1)
        }
    }
}

private extension TreePriorityPicker {
    func didSelect(priority: PersonPriority) {
        DispatchQueue.main.async {
            withAnimation {
                if selectedPriority == priority {
                    selectedPriority = nil
                } else {
                    selectedPriority = priority
                }
            }
        }
    }
    
    func getColor(for priority: PersonPriority) -> Color {
        switch priority {
        case .low:
            return .greenCustom
        case .medium:
            return .orangeCustom
        case .high:
            return .redCustom
        }
    }
}

#Preview {
    TreePriorityPicker(selectedPriority: .constant(nil))
}
