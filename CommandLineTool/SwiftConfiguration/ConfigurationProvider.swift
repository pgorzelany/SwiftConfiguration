import Foundation

class ConfigurationProvider {

    // MARK: - Properties

    private let configurationPlistPath: String

    // MARK: - Lifecycle

    init(configurationPlistPath: String) {
        self.configurationPlistPath = configurationPlistPath
    }

    // MARK: Methods

    func getConfigurations() throws -> [Configuration] {
        guard let configurationsDictionary = NSDictionary(contentsOfFile: configurationPlistPath) else {
            throw ConfigurationError(message: "Could not load configuration dictionary at: \(configurationPlistPath)")
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
