//
//  DefaultsService.swift
//
//  Created by Andrii Momot on 16.04.2024.
//

import Foundation

final class DefaultsService {
    static let shared = DefaultsService()
    private let standard = UserDefaults.standard
    private init() {}
}

extension DefaultsService {
    func removeAll() {
        if let bundleIdentifier = Bundle.main.bundleIdentifier {
            standard.removePersistentDomain(forName: bundleIdentifier)
        }
    }
    
    var flow: RootContentView.ViewState {
        get {
            let name = standard.string(forKey: Keys.flow.rawValue) ?? ""
            return RootContentView.ViewState(rawValue: name) ?? .onboarding
        }
        set {
            standard.set(newValue.rawValue, forKey: Keys.flow.rawValue)
        }
    }
}
 
extension DefaultsService {
    var people: [Person] {
        get {
            guard let data = standard.data(forKey: Keys.people.rawValue),
                  let items = try? JSONDecoder().decode([Person].self, from: data) else {
                return []
            }
            
            return items
        }
        set {
            if let data = try? JSONEncoder().encode(newValue) {
                standard.set(data, forKey: Keys.people.rawValue)
            }
        }
    }
}

// MARK: - Keys
extension DefaultsService {
    enum Keys: String {
        case flow
        case people
    }
}
