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
