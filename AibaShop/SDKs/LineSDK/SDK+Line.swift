import LineSDK

extension SDK.Line {
    static func setup() {
        LoginManager.shared.setup(channelID: Config.Line.channelId, universalLinkURL: nil)
    }

    static func handleUrl(_ url: URL) -> Bool {
        guard url.absoluteString.contains("line") else { return false }
        _ = LoginManager.shared.application(.shared, open: url)
        return true
    }
}
