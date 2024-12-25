//
//  TaskViewModel.swift
//  Golovytri
//
//  Created by Andrii Momot on 25.12.2024.
//

import Foundation
import UIKit.UIImage

extension TaskView {
    final class ViewModel: ObservableObject {
        @Published var isEditing = false
        @Published var image = UIImage()
        @Published var showImagePicker = false
        
        @Published var name = ""
        @Published var date = Date()
        @Published var days = ""
        @Published var budget = ""
        @Published var resources = ""
        let priorityItems = PersonPriority.allCases.map { $0.rawValue }
        @Published var priority = PersonPriority.allCases.first?.rawValue ?? ""
        @Published var description = ""
        
        func configure(state: TaskView.ViewState) {
            switch state {
            case .add:
                break
            case .edit(let model):
                DispatchQueue.main.async { [weak self] in
                    guard let self else { return }
                    self.isEditing = true
                }
            }
        }
    }
}

extension TaskView {
    enum ViewState {
        case add
        case edit(Person)
    }
}
