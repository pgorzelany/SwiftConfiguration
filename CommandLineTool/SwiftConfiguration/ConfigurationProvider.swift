import Foundation

class ConfigurationProvider {

    // MARK: Methods

    func getConfigurations(at configurationPlistFileUrl: URL) throws -> [Configuration] {
        guard let configurationsDictionary = NSDictionary(contentsOf: configurationPlistFileUrl) else {
            throw ConfigurationError(message: "Could not load configuration dictionary at: \(configurationPlistFileUrl)")
        }

        return try configurationsDictionary.map { configurationDictionary -> Configuration in
            print(configurationDictionary)
            guard let name = configurationDictionary.key as? String, let contents = configurationDictionary.value as? Dictionary<String, Any> else {
                throw ConfigurationError(message: "The configuration file has invalid format. Please refer to the docs.")
            }

            return Configuration(name: name, contents: contents)
        }
    }
}
