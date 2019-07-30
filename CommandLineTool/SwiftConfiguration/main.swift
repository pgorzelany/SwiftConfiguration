import Foundation

print(CommandLine.arguments)
private let printer = MessagePrinter()
private let argumentsParser = ArgumentsParser()
private let configurationKey = "Configuration"

do {
    let arguments = try argumentsParser.parseArguments(CommandLine.arguments)
    let infoPlistModifier = PlistModifier(plistFileUrl: arguments.plistFileUrl, configurationKey: configurationKey)
    let configurationProvider = ConfigurationProvider(configurationPlistFileUrl: arguments.configurationPlistFileUrl)
    let configurationValidator = ConfigurationValidator()
    let configurationManagerGenerator = ConfigurationManagerGenerator(outputFileUrl: arguments.outputFileUrl, configurationKey: configurationKey)
    let configurations = try configurationProvider.getConfigurations()
    try configurationValidator.validateConfigurations(configurations, activeEnvironmentName: arguments.activeEnvironmentName)
    try infoPlistModifier.addOrSetConfigurationKey()
    try configurationManagerGenerator.generateConfigurationManagerFile(for: configurations)
    exit(0)
} catch {
    printer.printWarning(error.localizedDescription)
    exit(0)
}
