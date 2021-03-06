import Foundation

class ConfigurationManagerTemplate {

    private let configurationDictionaryFileName: String
    private let configurationKey: String
    private let configurations: [Configuration]
    private let activeConfiguration: Configuration
    private lazy var configurationsString = generateConfigurationsString()
    private lazy var configurationsKeysString = generateConfigurationKeysString()
    private lazy var configurationPropertiesString = generateConfigurationPropertiesString()

    lazy var configurationManagerString = #"""
    // This file is autogenerated. Do not modify!
    // Generated by https://github.com/pgorzelany/SwiftConfiguration

    import Foundation

    class SwiftConfiguration {

        enum Configuration: String, CaseIterable {
            \#(configurationsString)
        }

        enum ConfigurationKey: String, CaseIterable {
            \#(configurationsKeysString)
        }

        // MARK: Shared instance

        static let current = SwiftConfiguration()

        // MARK: Properties

        private let configurationKey = "\#(configurationKey)"
        private let configurationPlistFileName = "\#(configurationDictionaryFileName)"
        private let activeConfigurationDictionary: NSDictionary
        let activeConfiguration: Configuration

        \#(configurationPropertiesString)

        // MARK: Lifecycle

        init(targetConfiguration: Configuration? = nil) {
            let bundle = Bundle(for: SwiftConfiguration.self)
            guard let rawConfiguration = bundle.object(forInfoDictionaryKey: configurationKey) as? String,
                let configurationDictionaryPath = bundle.path(forResource: configurationPlistFileName, ofType: nil),
                let activeConfiguration = targetConfiguration ?? Configuration(rawValue: rawConfiguration),
                let configurationDictionary = NSDictionary(contentsOfFile: configurationDictionaryPath),
                let activeEnvironmentDictionary = configurationDictionary[activeConfiguration.rawValue] as? NSDictionary
                else {
                    fatalError("Configuration Error")

            }
            self.activeConfiguration = activeConfiguration
            self.activeConfigurationDictionary = activeEnvironmentDictionary
        }

        // MARK: Methods

        func value<T>(for key: ConfigurationKey) -> T {
            guard let value = activeConfigurationDictionary[key.rawValue] as? T else {
                fatalError("No value satysfying requirements")
            }
            return value
        }

        func isRunning(in configuration: Configuration) -> Bool {
            return activeConfiguration == configuration
        }
    }
    """#

    init(configurations: [Configuration], activeConfiguration: Configuration, configurationKey: String, configurationPlistFilePath: String) {
        self.configurations = configurations
        self.activeConfiguration = activeConfiguration
        self.configurationKey = configurationKey
        self.configurationDictionaryFileName = (configurationPlistFilePath as NSString).lastPathComponent
    }

    func generateConfigurationsString() -> String {
        var configurationsString = ""
        let sortedConfigurations = configurations.sorted(by: {$0.name <= $1.name})
        for configuration in sortedConfigurations {
            let sanitizedConfigurationName = configuration.name
                .components(separatedBy: CharacterSet.letters.inverted)
                .joined()
            configurationsString += "case \(sanitizedConfigurationName) = \"\(configuration.name)\"\n\t\t"
        }
        return configurationsString
    }

    func generateConfigurationKeysString() -> String {
        var configurationsKeysString = ""
        let allKeys = Set(configurations.flatMap { $0.allKeys })
        for key in allKeys.sorted() {
            configurationsKeysString += "case \(key)\n\t\t"
        }
        return configurationsKeysString
    }

    func generateConfigurationPropertiesString() -> String {
        var configurationPropertiesString = ""
        let sortedContents = activeConfiguration.contents
            .sorted(by: {$0.key <= $1.key})
        for (key, value) in sortedContents {
            configurationPropertiesString += """

            \tvar \(key): \(getPlistType(for: value)) {
            \t\treturn value(for: .\(key))
            \t}\n\n
            """
        }
        return configurationPropertiesString
    }
}

private func getPlistType<T>(for value: T) -> String {
    if value is String {
        return "String"
    } else if let numberValue = value as? NSNumber {
        let boolTypeId = CFBooleanGetTypeID()
        let valueTypeId = CFGetTypeID(numberValue)
        if boolTypeId == valueTypeId {
            return "Bool"
        } else if value is Int {
            return "Int"
        } else if value is Double {
            return "Double"
        }
        fatalError("Unsuported type")
    } else if value is Date {
        return "Date"
    } else {
        fatalError("Unsuported type")
    }
}
