import Foundation

struct ConfigurationError: LocalizedError {

    private let message: String

    init(message: String) {
        self.message = message
    }

    var errorDescription: String? {
        return message
    }
}
