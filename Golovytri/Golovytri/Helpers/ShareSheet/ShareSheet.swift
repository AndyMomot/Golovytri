//
//  ShareSheet.swift
//  Libarorent
//
//  Created by Andrii Momot on 09.10.2024.
//

import Foundation
import SwiftUI

// ShareSheet struct to present UIActivityViewController in SwiftUI
struct ShareSheet: UIViewControllerRepresentable {
    var activityItems: [Any]
    
    func makeUIViewController(context: Context) -> UIActivityViewController {
        let controller = UIActivityViewController(activityItems: activityItems, applicationActivities: nil)
        return controller
    }
    
    func updateUIViewController(_ uiViewController: UIActivityViewController, context: Context) {
        // Nothing to update here
    }
}
