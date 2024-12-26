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
        @Published var priority = PersonPriority.low.rawValue
        @Published var description = ""
        
        func configure(state: TaskView.ViewState) {
            switch state {
            case .add:
                break
            case .edit(let model):
                fetchImage(id: model.id)
                DispatchQueue.main.async { [weak self] in
                    guard let self else { return }
                    self.isEditing = true
                    self.name = model.name
                    self.date = model.date
                    self.days = "\(model.days)"
                    self.budget = "\(model.budget)"
                    self.resources = model.resources
                    self.priority = model.priority.rawValue
                    self.description = model.description
                }
            }
        }
        
        func save(state: TaskView.ViewState, completion: @escaping () -> Void) {
            guard validate() else { return }
            
            switch state {
            case .add:
                DispatchQueue.global().async { [weak self] in
                    guard let self else { return }
                    
                    let person = Person(
                        name: self.name,
                        date: self.date,
                        days: Int(self.days) ?? .zero,
                        budget: Int(self.budget) ?? .zero,
                        resources: self.resources,
                        priority: PersonPriority(rawValue: self.priority) ?? .low,
                        description: self.description
                    )
                    
                    DefaultsService.shared.people.append(person)
                    
                    if let data = image.jpegData(compressionQuality: 1) {
                        FileManagerService().saveImage(data: data, for: person.id)
                    }
                    
                    DispatchQueue.main.async {
                        completion()
                    }
                }
            case .edit(var person):
                DispatchQueue.global().async { [weak self] in
                    guard let self else { return }
                    
                    person.name = self.name
                    person.date = self.date
                    person.days = Int(self.days) ?? .zero
                    person.budget = Int(self.budget) ?? .zero
                    person.resources = self.resources
                    person.priority = PersonPriority(rawValue: self.priority) ?? .low
                    person.description = self.description
                    
                    let shared = DefaultsService.shared
                    if let index = shared.people.firstIndex(where: { $0.id == person.id }) {
                        shared.people[index] = person
                    }
                    
                    if let data = image.jpegData(compressionQuality: 1) {
                        FileManagerService().saveImage(data: data, for: person.id)
                    }
                    
                    DispatchQueue.main.async {
                        completion()
                    }
                }
            }
        }
        
        func delete(state: TaskView.ViewState, completion: @escaping () -> Void) {
            switch state {
            case .add:
                break
            case .edit(let person):
                DispatchQueue.global().async {
                    DefaultsService.shared.people.removeAll(where: {$0.id == person.id })
                    
                    DispatchQueue.main.async {
                        completion()
                    }
                }
            }
        }
    }
}

private extension TaskView.ViewModel {
    func fetchImage(id: String) {
        Task {
            guard let data = await FileManagerService().fetchImage(with: id),
                  let uiImage = UIImage(data: data) else {
                return
            }
            
            DispatchQueue.main.async { [weak self] in
                self?.image = uiImage
            }
        }
    }
    
    func validate() -> Bool {
        return image != UIImage()
        && !name.isEmpty
        && !name.isEmpty
        && Int(days) != nil
        && Int(budget) != nil
        && !resources.isEmpty
        && !priority.isEmpty
        && !description.isEmpty
    }
}

extension TaskView {
    enum ViewState {
        case add
        case edit(Person)
    }
}
