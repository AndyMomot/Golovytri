//
//  View+Additions.swift

import SwiftUI

extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners))
    }
    
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
    
    func hideKeyboardWhenTappedAround() -> some View {
        self.onTapGesture {
            self.hideKeyboard()
        }
    }
    
    func share(url: String) {
        let activityController = UIActivityViewController(activityItems: [url], applicationActivities: nil)
        
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let rootViewController = windowScene.windows.first?.rootViewController {
            
            // For iPads, you need to set the sourceView and sourceRect for the popover
            if let popoverController = activityController.popoverPresentationController {
                popoverController.sourceView = rootViewController.view // Set to the root view or any view you want to anchor the popover
                popoverController.sourceRect = CGRect(x: rootViewController.view.bounds.midX,
                                                      y: rootViewController.view.bounds.midY,
                                                      width: 0,
                                                      height: 0) // Center of the view
                popoverController.permittedArrowDirections = [] // No arrow needed
            }
            
            rootViewController.present(activityController, animated: true, completion: nil)
        }
    }
    
    func convertMinutesInTime(minutes: Int) -> String {
        // Calculate hours and minutes
        let hours = minutes / 60
        let minutes = minutes % 60

        // Format as "HH:mm"
        let formattedTime = String(format: "%02d:%02d", hours, minutes)
        return formattedTime
    }
}

struct RoundedCorner: Shape {
    var radius: CGFloat
    var corners: UIRectCorner
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect,
                                byRoundingCorners: corners,
                                cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}

extension View {
    @ViewBuilder
    func hidden(_ shouldHide: Bool) -> some View {
        if shouldHide {
            self.hidden()
        } else {
            self
        }
    }
}
