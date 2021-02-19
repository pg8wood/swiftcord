public enum Swiftcord {
    private static var _discordToken: String?
    static var discordToken: String {
        get {
            guard let discordToken = _discordToken else {
                fatalError("You must setup the SDK with Swiftcord.setup(discordToken: <your token>) before using the SDK!")
            }
            return discordToken
        } set {
            _discordToken = newValue
        }
    }
    
    public static func setup(discordToken: String) {
        self.discordToken = discordToken
    }
}
