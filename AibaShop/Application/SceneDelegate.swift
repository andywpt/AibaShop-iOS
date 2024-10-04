import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    func scene(_ scene: UIScene, willConnectTo _: UISceneSession, options _: UIScene.ConnectionOptions) {
        // Exit early in non-production environment
        if Environment.isRunningUnitTests { return }
        if Environment.isRunningSwiftUIPreviews { return }

        guard let windowScene = scene as? UIWindowScene else { return }
        let rootViewController = ContentWrapperController()
        window = UIWindow(windowScene: windowScene).with {
            $0.rootViewController = DemoViewController()
            $0.makeKeyAndVisible()
        }
    }
}

extension SceneDelegate {
    func didReceivePushNotification(_: UNNotification) {}
}
