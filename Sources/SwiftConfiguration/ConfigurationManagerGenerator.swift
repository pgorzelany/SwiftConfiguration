import Foundation

public class ConfigurationManagerGenerator {

    // MARK: - Properties

    private let configurationPlistFilePath: String
    private let outputFilePath: String
    private let configurationKey: String
    private lazy var fileManager = FileManager.default

    // MARK: - Lifecycle

    public init(configurationPlistFilePath: String, outputFilePath: String, configurationKey: String) {
        self.outputFilePath = outputFilePath
        self.configurationKey = configurationKey
        self.configurationPlistFilePath = configurationPlistFilePath
    }

    // MARK: - Methods

    public func generateConfigurationManagerFile(for configurations: [Configuration], activeConfiguration: Configuration) throws {
        let template = ConfigurationManagerTemplate(configurations: configurations,
                                                    activeConfiguration: activeConfiguration,
                                                    configurationKey: configurationKey,
                                                    configurationPlistFilePath: configurationPlistFilePath)
        if fileManager.fileExists(atPath: outputFilePath) {
            try template.configurationManagerString.write(toFile: outputFilePath, atomically: true, encoding: .utf8)
        } else {
            let outputFileUrl = URL(fileURLWithPath: outputFilePath)
            let outputFileDirectoryUrl = outputFileUrl.deletingLastPathComponent()
            try fileManager.createDirectory(at: outputFileDirectoryUrl, withIntermediateDirectories: true, attributes: nil)
            try template.configurationManagerString.write(toFile: outputFilePath, atomically: true, encoding: .utf8)
        }
    }
}
