import SwiftUI

final class RootViewController: UIViewController {
    private let swiftUIViewController = UIHostingController(rootView: RootContentView())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showSwiftUIView()
    }
}

private extension RootViewController {
    func showSwiftUIView() {
        // Добавляем новый контроллер как дочерний
        addChild(swiftUIViewController)
        view.addSubview(swiftUIViewController.view)
        swiftUIViewController.didMove(toParent: self)
        
        // Настраиваем ограничения для tabBarViewController
        swiftUIViewController.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            swiftUIViewController.view.topAnchor.constraint(equalTo: view.topAnchor),
            swiftUIViewController.view.leftAnchor.constraint(equalTo: view.leftAnchor),
            swiftUIViewController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            swiftUIViewController.view.rightAnchor.constraint(equalTo: view.rightAnchor)
        ])
    }
    
    func removeSwiftUIView() {
        swiftUIViewController.willMove(toParent: nil)
        swiftUIViewController.view.removeFromSuperview()
        swiftUIViewController.removeFromParent()
    }
}
