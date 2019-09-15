import Foundation
import SwiftConfiguration

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
    do {
        try configurationValidator.validateConfigurations(configurations, activeConfigurationName: environment.activeConfigurationName)
    } catch {
        printer.printWarning(error.localizedDescription)
    }
    try infoPlistModifier.addOrSetConfigurationKey()
    let activeConfiguration = try configurationProvider.getConfiguration(at: arguments.configurationPlistFilePath, for: environment.activeConfigurationName)
    try configurationManagerGenerator.generateConfigurationManagerFile(for: configurations, activeConfiguration: activeConfiguration)
    exit(0)
} catch {
    printer.printError(error.localizedDescription)
    exit(0)
}
