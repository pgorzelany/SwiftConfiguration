import Foundation

class ConfigurationManagerTemplate {

    private let configurationDictionaryFileName: String
    private let configurationKey: String
    private let configurationsString: String
    private let configurationsKeysString: String
    private let configurationPropertiesString: String

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
        var configurationsString = ""
        var configurationsKeysString = ""
        var allKeys = Set<String>()
        for configuration in configurations {
            let sanitizedConfigurationName = configuration.name.components(separatedBy: CharacterSet.letters.inverted).joined()
            configurationsString += "case \(sanitizedConfigurationName) = \"\(configuration.name)\"\n\t\t"
            allKeys = allKeys.union(configuration.allKeys)
        }
        for key in allKeys {
            configurationsKeysString += "case \(key)\n\t\t"
        }

        var configurationPropertiesString = ""
        for (key, value) in activeConfiguration.contents {
            configurationPropertiesString += """

            \tvar \(key): \(getPlistType(for: value)) {
            \t\treturn value(for: .\(key))
            \t}\n\n
            """
        }

        self.configurationsString = configurationsString
        self.configurationsKeysString = configurationsKeysString
        self.configurationKey = configurationKey
        self.configurationDictionaryFileName = (configurationPlistFilePath as NSString).lastPathComponent
        self.configurationPropertiesString = configurationPropertiesString
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
