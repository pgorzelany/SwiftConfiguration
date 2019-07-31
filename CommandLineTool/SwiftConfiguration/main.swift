import Foundation

print(CommandLine.arguments)
private let printer = MessagePrinter()
private let argumentsParser = ArgumentsParser()
private let configurationKey = "Configuration"

do {
    let arguments = try argumentsParser.parseArguments(CommandLine.arguments)
    let infoPlistModifier = PlistModifier(plistFilePath: arguments.plistFilePath, configurationKey: configurationKey)
    let configurationProvider = ConfigurationProvider()
    let configurationValidator = ConfigurationValidator()
    let configurationManagerGenerator = ConfigurationManagerGenerator(outputFilePath: arguments.outputFilePath, configurationKey: configurationKey)
    let configurations = try configurationProvider.getConfigurations(at: arguments.configurationPlistFilePath)
    try configurationValidator.validateConfigurations(configurations, activeEnvironmentName: arguments.activeEnvironmentName)
    try infoPlistModifier.addOrSetConfigurationKey()
    try configurationManagerGenerator.generateConfigurationManagerFile(for: configurations)
    exit(0)
} catch {
    printer.printWarning(error.localizedDescription)
    exit(0)
}
