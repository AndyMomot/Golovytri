//
//  OnboardingViewModel.swift
//  Goobeltoin
//
//  Created by Andrii Momot on 12.06.2024.
//

import Foundation

extension OnboardingView {
    final class OnboardingViewModel: ObservableObject {
        @Published var showPrivacyPolicy = false
        let privacyPolicyURL = URL(string: "https://google.com")
    }
    
    enum OnboardingItem: Int, CaseIterable {
        case first = 0
        case second
        case third
        
        var image: String {
            switch self {
            case .first:
                return Asset.onboard1.name
            case .second:
                return Asset.onboard2.name
            case .third:
                return Asset.onboard3.name
            }
        }
        
        var text: String {
            switch self {
            case .first:
                return "Tato aplikace vám pomůže organizovat úkoly s jasnou strukturou a viditelnými vzahy mezi nimi. Můžete snadno vyhodnotit zdroje potřebné k vykonání každého úkolu."
            case .second:
                return "Díky vizuální struktuře ve formě stromu budete moci rychle pochopit, jak úkoly spolu vzájemně souvisejí. Interaktivita umožňuje rychle upravovat a aktualizovat plány."
            case .third:
                return "Tento organizátor vám umožní nejen zadávat úkoly, ale také kontrolovat jejich pokrok a hodnotit náklady. Můžete spravovat projekty s ohledem na zdroje, čas a priority."
            }
        }

        var next: Self {
            switch self {
            case .first:
                return .second
            case .second, .third:
                return .third
            }
        }
    }
}
