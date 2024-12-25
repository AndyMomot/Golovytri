//
//  HomeViewModel.swift
//  Golovytri
//
//  Created by Andrii Momot on 17.12.2024.
//

import Foundation

extension HomeView {
    final class ViewModel: ObservableObject {
        @Published var people: [Person] = []
        @Published var priority: PersonPriority?
        @Published var treeItems: [TreeItem] = []
        
        @Published var showAddTask = false
        
        init() {
            getPeople()
        }
        
        func getPeople() {
            DispatchQueue.global().async { [weak self] in
                guard let self else { return }
                let people = DefaultsService.shared.people
                let treeItems = people.map { TreeItem(id: $0.id, priority: $0.priority) }
                 
                DispatchQueue.main.async { [self] in
                    self.people = people
                    self.treeItems = treeItems
                }
            }
        }
    }
}
