import FirebaseAppCheck
import FirebaseCore
import GoogleSignIn

extension SDK.Firebase {
    static func setup() {
        configureAppCheck()
        configureFirebaseApp()
        configureGoogleSignIn()
    }

    static func handleUrl(_ url: URL) -> Bool {
        guard url.absoluteString.contains("google") else { return false }
        GIDSignIn.sharedInstance.handle(url)
        return true
    }

    private static func configureAppCheck() {
        class AppCheckDefaultProviderFactory: NSObject, AppCheckProviderFactory {
            func createProvider(with app: FirebaseApp) -> AppCheckProvider? {
                AppAttestProvider(app: app)
            }
        }
        if Environment.isRunningOnSimulator {
            AppCheck.setAppCheckProviderFactory(AppCheckDebugProviderFactory())
        } else {
            AppCheck.setAppCheckProviderFactory(AppCheckDefaultProviderFactory())
        }
    }

    private static func configureFirebaseApp() {
        FirebaseApp.configure()
    }

    private static func configureGoogleSignIn() {
        let clientID = FirebaseApp.app()!.options.clientID!
        GIDSignIn.sharedInstance.configuration = GIDConfiguration(clientID: clientID)
    }
}
