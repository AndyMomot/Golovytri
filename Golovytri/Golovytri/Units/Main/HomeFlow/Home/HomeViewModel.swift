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
        @Published var peopleForList: [Person] = []
        @Published var priority: PersonPriority?
        @Published var treeItems: [TreeItem] = []
        @Published var showAddTask = false
        
        var personToShow: Person?
        @Published var showPersonDetails = false
        
        func getPeople() {
            DispatchQueue.global().async { [weak self] in
                guard let self else { return }
                let people = DefaultsService.shared.people
                let treeItems = people.map { TreeItem(id: $0.id, priority: $0.priority) }
                var peopleForList = [Person]()
                
                if let priority {
                    peopleForList = people.filter { $0.priority == priority }
                } else {
                    peopleForList = people
                }
                 
                DispatchQueue.main.async { [self] in
                    self.people = people
                    self.treeItems = treeItems
                    self.peopleForList = peopleForList
                }
            }
        }
        
        func onSelectTreeItem(_ item: TreeItem) {
            DispatchQueue.main.async { [weak self] in
                guard let self, let person = self.people.first(where: {
                    $0.id == item.id
                }) else { return }
                self.onSelectPerson(person)
            }
        }
        
        func onSelectPerson(_ item: Person) {
            DispatchQueue.main.async { [weak self] in
                guard let self else { return }
                self.personToShow = item
                self.showPersonDetails.toggle()
            }
        }
    }
}
