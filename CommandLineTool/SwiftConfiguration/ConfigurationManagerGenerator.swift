
class ConfigurationManagerGenerator {

    // MARK: - Properties

    private let outputFilePath: String
    private let configurationKey: String

    // MARK: - Lifecycle

    init(outputFilePath: String, configurationKey: String) {
        self.outputFilePath = outputFilePath
        self.configurationKey = configurationKey
    }

    // MARK: - Methods

    func generateConfigurationManagerFile(for configurations: [Configuration]) throws {
        let template = ConfigurationManagerTemplate(configurations: configurations, configurationKey: configurationKey)
        try template.configurationManagerString.write(toFile: outputFilePath, atomically: true, encoding: .utf8)
    }
}
