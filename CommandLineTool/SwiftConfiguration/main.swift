import Foundation

private let environment = ProcessInfo.processInfo.environment
private let printer = MessagePrinter()
private let environmentParser = EnvironmentParser()
private let argumentsParser = ArgumentsParser()
private let configurationProvider = ConfigurationProvider()
private let configurationValidator = ConfigurationValidator()
private let configurationKey = "SwiftConfiguration.currentConfiguration"

do {
    let environment = try environmentParser.parseEnvironment()
    let arguments = try argumentsParser.parseArguments(CommandLine.arguments)
    let infoPlistModifier = PlistModifier(plistFilePath: environment.plistFilePath, configurationKey: configurationKey)
    let configurationManagerGenerator = ConfigurationManagerGenerator(configurationPlistFilePath: arguments.configurationPlistFilePath,
                                                                      outputFilePath: arguments.outputFilePath,
                                                                      configurationKey: configurationKey)
    let configurations = try configurationProvider.getConfigurations(at: arguments.configurationPlistFilePath)
    try configurationValidator.validateConfigurations(configurations, activeConfigurationName: environment.activeConfigurationName)
    try infoPlistModifier.addOrSetConfigurationKey()
    try configurationManagerGenerator.generateConfigurationManagerFile(for: configurations)
    exit(0)
} catch {
    printer.printWarning(error.localizedDescription)
    exit(0)
}
