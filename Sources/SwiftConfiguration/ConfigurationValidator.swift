
public class ConfigurationValidator {

    private let messagePrinter: MessagePrinter

    public init(messagePrinter: MessagePrinter) {
        self.messagePrinter = messagePrinter
    }

    // MARK: - Public Methods

    public func validateConfigurations(_ configurations: [Configuration], activeConfigurationName: String) throws {
        let allKeys = configurations.reduce(Set<String>(), { (result, configuration) -> Set<String> in
                return result.union(configuration.allKeys)
            })
        for configuration in configurations {
            let difference = allKeys.subtracting(configuration.allKeys)
            if !difference.isEmpty {
                for key in difference {
                    messagePrinter.printWarning("Missing key: \(key) in configuration: \(configuration.name)")
                }
            }
        }

        let configurationNames = configurations.map({$0.name})
        guard configurationNames.contains(where: {$0 == activeConfigurationName}) else {
            throw ConfigurationError(message: "The configuration file does not contain a configuration for the active configuration (\(activeConfigurationName))")
        }
    }
}
