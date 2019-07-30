import Foundation

class ConfigurationManagerGenerator {

    // MARK: - Properties

    private let outputFileUrl: URL
    private let configurationKey: String

    // MARK: - Lifecycle

    init(outputFileUrl: URL, configurationKey: String) {
        self.outputFileUrl = outputFileUrl
        self.configurationKey = configurationKey
    }

    // MARK: - Methods

    func generateConfigurationManagerFile(for configurations: [Configuration]) throws {
        let template = ConfigurationManagerTemplate(configurations: configurations, configurationKey: configurationKey)
        try template.configurationManagerString.write(to: outputFileUrl, atomically: true, encoding: .utf8)
    }
}
