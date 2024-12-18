//
//  InvertedPyramidView.swift
//  Golovytri
//
//  Created by Andrii Momot on 17.12.2024.
//

import SwiftUI

struct InvertedPyramidView: View {
    let people: [TreeItem]
    var priority: PersonPriority?
    
    var body: some View {
        VStack(spacing: 10) {
            ForEach(levels().reversed(), id: \.self) { level in
                HStack(spacing: 10) {
                    ForEach(level, id: \.self) { person in
                        var opacity: CGFloat {
                            guard priority != nil else { return 1 }
                            return person.priority == self.priority ? 1 : 0.2
                        }
                        
                        TreeCell(person: person)
                            .frame(width: 50, height: 50)
                            .opacity(opacity)
                    }
                }
            }
        }
        .padding()
    }
    
    // Функція для обчислення рівнів і кольорів на кожному рівні
    private func levels() -> [[TreeItem]] {
        var result: [[TreeItem]] = []
        var startIndex = 0
        
        for level in 1... {
            let endIndex = min(startIndex + level, people.count)
            if startIndex < people.count {
                result.append(Array(people[startIndex..<endIndex]))
                startIndex = endIndex
            } else {
                break
            }
        }
        return result
    }
}

#Preview {
    InvertedPyramidView(people: [
        .init(id: "0", priority: .low),
        .init(id: "1", priority: .medium),
        .init(id: "2", priority: .high),
        
            .init(id: "3", priority: .low),
        .init(id: "4", priority: .medium),
        .init(id: "5", priority: .high),
        
            .init(id: "6", priority: .low),
        .init(id: "7", priority: .medium),
        .init(id: "8", priority: .high),
        .init(id: "9", priority: .high)
    ], priority: .high)
}
