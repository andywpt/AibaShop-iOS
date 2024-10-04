import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    private let firebaseMessagingService = FirebaseMessagingService()
    func application(_: UIApplication, didFinishLaunchingWithOptions _: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Exit early in non-production environment
        if Environment.isRunningSwiftUIPreviews { return true }
        if Environment.isRunningUnitTests { return true }
        
        // Configure SDKs
        SDK.Firebase.setup()
        SDK.TapPay.setup()
        SDK.Line.setup()
        
        // Configure push notifications
        UNUserNotificationCenter.current().delegate = self
        Task {
            await configurePushNotifications()
        }
        return true
    }

    func application(_: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken token: Data) {
        firebaseMessagingService.handle(token)
        //  deviceTokenHandler.handle(deviceToken)
    }

    func application(_: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: any Error) {
        print("⚠️ Failed to register push notifications: \(error)")
    }
    
    private func configurePushNotifications() async {
        let service = UNUserNotificationCenter.current()
        let status = await service.notificationSettings().authorizationStatus
        if status == .notDetermined {
            _ = try? await service.requestAuthorization(options: [
                .alert, .badge, .providesAppNotificationSettings,
            ])
        }
        // Always call 'requestAuthorization' before scheduling any local notifications and before registering with the Apple Push Notification service.
        UIApplication.shared.registerForRemoteNotifications()
    }
}

extension AppDelegate: UNUserNotificationCenterDelegate {
    // Called only if the app is frontmost when the local notification fires, forward it to the scene delegate
    @MainActor func userNotificationCenter(_: UNUserNotificationCenter, willPresent notification: UNNotification) async -> UNNotificationPresentationOptions {
        // We wanted to display local notifications but never display push notifications as we handle them in-app with a custom UI:
        // if response.notification.request.trigger is UNPushNotificationTrigger
        let scene = UIApplication.shared.connectedScenes
            .filter { $0.activationState == .foregroundActive }
            .compactMap { $0 as? UIWindowScene }
            .first
        if let sceneDelegate = scene?.delegate as? SceneDelegate {
            sceneDelegate.didReceivePushNotification(notification)
        }
        return []
    }
}


