//
//  CalculatorViewModel.swift
//  Golovytri
//
//  Created by Andrii Momot on 28.12.2024.
//

import Foundation
import SwiftUI

extension CalculatorView {
    final class CalculatorViewModel: ObservableObject {
        @Published var mainTask: Person?
        @Published var subtasks: [Person] = []
        
        @Published var image: Image?
        @Published var priorityColor = Color.greenCustom
        
        @Published var isEditing = false
        @Published var showLoading = false
        
        func getTasks() {
            DispatchQueue.global().async { [weak self] in
                guard let self else { return }
                let tasks = DefaultsService.shared.people
                let mainTask = tasks.first
                let subtasks = Array(tasks.dropFirst())
                
                if let mainTask {
                    self.getColor(for: mainTask)
                    self.fetchImage(id: mainTask.id)
                }
                 
                DispatchQueue.main.async { [self] in
                    self.mainTask = mainTask
                    self.subtasks = subtasks
                }
            }
        }
        
        func updateSubtasks() {
            DispatchQueue.main.async { [weak self] in
                self?.showLoading = true
            }
            
            DispatchQueue.global().async { [weak self] in
                guard let self else { return }
                let subtasks = Array(DefaultsService.shared.people.dropFirst())
                 
                DispatchQueue.main.async { [self] in
                    self.subtasks = subtasks
                    self.showLoading = false
                }
            }
        }
        
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
        
        func getColor(for task: Person) {
            DispatchQueue.global().async {
                var color: Color {
                    switch task.priority {
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
                        self.priorityColor = color
                    }
                }
            }
        }
        
        func handle(action: PersonCell.ViewAction, for task: Person) {
            DispatchQueue.global().async { [weak self] in
                let shared = DefaultsService.shared
                guard let index = shared.people.firstIndex(where: { $0.id == task.id}) else {
                    return
                }
                
                switch action {
                case .minusDay:
                    shared.people[index].days -= 1
                case .plusDay:
                    shared.people[index].days += 1
                case .minusBudget:
                    shared.people[index].budget -= 1
                case .plusBudget:
                    shared.people[index].budget += 1
                }
                
                self?.updateSubtasks()
            }
        }
    }
}
