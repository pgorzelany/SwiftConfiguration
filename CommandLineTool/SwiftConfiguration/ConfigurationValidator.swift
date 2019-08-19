
class ConfigurationValidator {

    // MARK: - Public Methods

    func validateConfigurations(_ configurations: [Configuration], activeConfigurationName: String) throws {
        let allKeys = configurations.reduce(Set<String>(), { (result, configuration) -> Set<String> in
                return result.union(configuration.allKeys)
            })
        for configuration in configurations {
            let difference = allKeys.subtracting(configuration.allKeys)
            if !difference.isEmpty {
                var warning = ""
                for key in difference {
                    warning += "Missing key: \(key) in configuration: \(configuration.name)\n"
                }
                throw ConfigurationError(message: warning)
            }
        }

        let configurationNames = configurations.map({$0.name})

        guard configurationNames.contains(where: {$0 == activeConfigurationName}) else {
            throw ConfigurationError(message: "The configuration file does not contain a configuration for the active configuration (\(activeConfigurationName))")
        }
    }
}
