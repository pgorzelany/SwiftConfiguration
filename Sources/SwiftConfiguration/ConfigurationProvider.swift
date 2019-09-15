import Foundation

public class ConfigurationProvider {

    public init() {}

    // MARK: Methods

    public func getConfigurations(at configurationPlistFilePath: String) throws -> [Configuration] {
        guard let configurationsDictionary = NSDictionary(contentsOfFile: configurationPlistFilePath) else {
            throw ConfigurationError(message: "Could not load configuration dictionary at: \(configurationPlistFilePath)")
        }

        return try configurationsDictionary.map { configurationDictionary -> Configuration in
            print(configurationDictionary)
            guard let name = configurationDictionary.key as? String, let contents = configurationDictionary.value as? Dictionary<String, Any> else {
                throw ConfigurationError(message: "The configuration file has invalid format. Please refer to the docs.")
            }

            return Configuration(name: name, contents: contents)
        }
    }

    public func getConfiguration(at configurationPlistFilePath: String, for configurationName: String) throws -> Configuration {
        let configurations = try getConfigurations(at: configurationPlistFilePath)
        guard let configuration = configurations.first(where: { $0.name == configurationName }) else {
            throw ConfigurationError(message: "Could not get configuration dictionary for configurationName: \(configurationName)")
        }

        return configuration
    }
}
