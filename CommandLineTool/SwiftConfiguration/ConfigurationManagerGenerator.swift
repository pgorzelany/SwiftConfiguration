import Foundation

class ConfigurationManagerGenerator {

    // MARK: - Properties

    private let configurationPlistFilePath: String
    private let outputFilePath: String
    private let configurationKey: String

    // MARK: - Lifecycle

    init(configurationPlistFilePath: String, outputFilePath: String, configurationKey: String) {
        self.outputFilePath = outputFilePath
        self.configurationKey = configurationKey
        self.configurationPlistFilePath = configurationPlistFilePath
    }

    // MARK: - Methods

    func generateConfigurationManagerFile(for configurations: [Configuration]) throws {
        let template = ConfigurationManagerTemplate(configurations: configurations, configurationKey: configurationKey, configurationPlistFilePath: configurationPlistFilePath)
        try template.configurationManagerString.write(toFile: outputFilePath, atomically: true, encoding: .utf8)
    }
}
