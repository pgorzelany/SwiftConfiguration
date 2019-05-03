#!/usr/bin/env xcrun --sdk macosx swift

import Foundation

print(CommandLine.arguments)
private let configurationKey = "Configuration"
private let plistFilePath = CommandLine.arguments[1]
private let configurationPlistPath = CommandLine.arguments[2]
private let outputFilePath = CommandLine.arguments[3]
private let activeEnvironmentName = CommandLine.arguments[4]

let infoPlistModifier = PlistModifier(plistFilePath: plistFilePath, configurationKey: configurationKey)
let configurationProvider = ConfigurationProvider(configurationPlistPath: configurationPlistPath)
let configurationValidator = ConfigurationValidator(activeEnvironmentName: activeEnvironmentName)
let configurationManagerGenerator = ConfigurationManagerGenerator(outputFilePath: outputFilePath, configurationKey: configurationKey)

do {
    let configurations = try configurationProvider.getConfigurations()
    try configurationValidator.validateConfigurations(configurations)
    try configurationManagerGenerator.generateConfigurationManagerFile(for: configurations)
    try infoPlistModifier.addOrSetConfigurationKey()
    exit(0)
} catch {
    print(error.localizedDescription)
    exit(1)
}
