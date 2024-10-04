import Combine
import FirebaseMessaging
import Foundation

@MainActor // ⚠️ FCM is not thread-safe
final class FirebaseMessagingService: NSObject {
    private var subscriptions = Set<AnyCancellable>()

    func handle(_ deviceToken: Data) {
        Messaging.messaging().delegate = self
        return
//        Messaging.messaging().apnsToken = deviceToken
//
//        userSignedInPublisher
//            .await { signedIn in
//                if signedIn {
//                    let token = try await Messaging.messaging().token()
//                    // updateUserFcmToken
//                } else {
//                    // User signed out, refresh token
//                    try await Messaging.messaging().deleteToken()
//                    try await Messaging.messaging().token()
//                }
//            }
//            .sink { _ in
//            }
    }
}

extension FirebaseMessagingService: MessagingDelegate {
    nonisolated func messaging(_: Messaging, didReceiveRegistrationToken fcmToken: String?) {
        // Make sure the app has already received a fcm token before subscribing to a topic
        guard let fcmToken else { return }
        print("🔥 Did receive fcm token: \(fcmToken)")
        Messaging.messaging().subscribe(toTopic: "Test") { error in
            if let error {
                print("⚠️ Cannot subscribe to topic")
            } else {
                print("✅ Subscribed to topic 'Test'")
            }
        }
    }
}
