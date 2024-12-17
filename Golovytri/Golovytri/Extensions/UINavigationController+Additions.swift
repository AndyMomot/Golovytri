//
//  UINavigationController+Additions.swift
//  DriverProPl
//
//  Created by Andrii Momot on 13.08.2024.
//

import Foundation
import UIKit

// Swipe-back gesture if navigation bar back button is hidden
extension UINavigationController: UIGestureRecognizerDelegate {
    override open func viewDidLoad() {
        super.viewDidLoad()
        interactivePopGestureRecognizer?.delegate = self
    }
    
    public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return viewControllers.count > 1
    }
}
