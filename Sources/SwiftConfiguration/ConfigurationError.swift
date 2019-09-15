import Foundation

public struct ConfigurationError: LocalizedError {

    private let message: String

    init(message: String) {
        self.message = message
    }

    public var errorDescription: String? {
        return message
    }
}
