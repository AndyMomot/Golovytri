//
//  StatisticsViewModel.swift
//  Golovytri
//
//  Created by Andrii Momot on 28.12.2024.
//

import Foundation

extension StatisticsView {
    final class ViewModel: ObservableObject {
        @Published var tasksGroupedByDate: [Date: [Person]] = [:]
        @Published var barChartData: [(date: Date, low: Int, medium: Int, high: Int)] = []
        
        @Published var lowPercent = 0.0
        @Published var mediumPercent = 0.0
        @Published var highPercent = 0.0
        
        @Published var tasks: [Person] = []
        
        func getTasks() {
            DispatchQueue.global().async { [weak self] in
                guard let self else { return }
                let tasks = DefaultsService.shared.people
                
                self.setBarChartData(tasks: tasks)
                self.setPercents(tasks: tasks)
                
                DispatchQueue.main.async { [self] in
                    self.tasks = tasks
                }
            }
        }
        
        func setBarChartData(tasks: [Person]) {
            DispatchQueue.global().async { [weak self] in
                guard let self else { return }
                let groupedItems = tasks.reduce(into: [Date: [Person]]()) { result, item in
                    let date = item.date.format(to: .ddMMyyyy) ?? item.date
                    if result[date] != nil {
                        result[date]?.append(item)
                    } else {
                        result[date] = [item]
                    }
                }
                
                let sortedGroupedItems = Dictionary(
                    uniqueKeysWithValues: groupedItems
                        .sorted(by: { $0.key > $1.key })
                )
                
                var chartData: [(date: Date, low: Int, medium: Int, high: Int)] {
                    sortedGroupedItems.map { (key: Date, value: [Person]) in
                        (
                            date: key,
                            low: value.filter {$0.priority == .low}.count,
                            medium: value.filter {$0.priority == .medium}.count,
                            high: value.filter {$0.priority == .high}.count
                        )
                    }.sorted(by: { $0.date < $1.date }) // Сортуємо за датою
                }
                
                DispatchQueue.main.async { [self] in
                    self.barChartData = chartData
                }
            }
        }
        
        func setPercents(tasks: [Person]) {
            let total = Double(tasks.count)
            let low = Double(tasks.filter {$0.priority == .low}.count) / total
            let medium = Double(tasks.filter {$0.priority == .medium}.count) / total
            let high = Double(tasks.filter {$0.priority == .high}.count) / total
            
            DispatchQueue.main.async { [weak self] in
                guard let self else { return }
                self.lowPercent = low
                self.mediumPercent = medium
                self.highPercent = high
            }
        }
    }
}
