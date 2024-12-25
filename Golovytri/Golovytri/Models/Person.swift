//
//  Person.swift
//  Golovytri
//
//  Created by Andrii Momot on 17.12.2024.
//

import Foundation

struct Person: Identifiable, Codable {
    private(set) var id = UUID().uuidString
    var name: String
    var date: Date
    var days, budget: Int
    var resources: String
    var priority: PersonPriority
    var description: String
}

enum PersonPriority: String, Codable, CaseIterable {
    case low = "Nízká"
    case medium = "Střední"
    case high = "Vysoká"
}
