import Foundation

class ConfigurationProvider {

    // MARK: - Properties

    private let configurationPlistFilePath: String

    // MARK: - Lifecycle

    init(configurationPlistFilePath: String) {
        self.configurationPlistFilePath = configurationPlistFilePath
    }

    // MARK: Methods

    func getConfigurations() throws -> [Configuration] {
        guard let configurationsDictionary = NSDictionary(contentsOfFile: configurationPlistFilePath) else {
            throw ConfigurationError(message: "Could not load configuration dictionary at: \(configurationPlistFilePath)")
        }

        return try configurationsDictionary.map { configurationDictionary -> Configuration in
            print(configurationDictionary)
            guard let name = configurationDictionary.key as? String, let contents = configurationDictionary.value as? Dictionary<String, Any> else {
                throw ConfigurationError(message: "The configuration file has invalid format. Please consult the docs.")
            }

            return Configuration(name: name, contents: contents)
        }
    }
}
