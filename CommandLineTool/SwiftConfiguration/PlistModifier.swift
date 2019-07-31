
import Foundation

/// Modifies the plist file by adding the configuration key
/// The value indicates the current runtime configuration
class PlistModifier {

    // MARK: - Properties

    private let plistFilePath: String
    private let configurationKey: String
    private let configurationValue = "$(CONFIGURATION)"
    private let plistBuddyPath = "/usr/libexec/PlistBuddy"

    // MARK: - Lifecycle

    init(plistFilePath: String, configurationKey: String) {
        self.plistFilePath = plistFilePath
        self.configurationKey = configurationKey
    }

    // MARK: - Methods

    func addOrSetConfigurationKey() throws {
        if invokeShell(with: plistBuddyPath, "-c", "Add :\(configurationKey) string \(configurationValue)", "\(plistFilePath)") != 0 {
            guard invokeShell(with: plistBuddyPath, "-c", "Set :\(configurationKey) \(configurationValue)", "\(plistFilePath)") == 0 else {
                throw ConfigurationError(message: "Could not modify InfoPlist file")
            }
        }
    }

    private func invokeShell(with args: String...) -> Int32 {
        let task = Process()
        task.launchPath = "/usr/bin/env"
        task.arguments = args
        task.launch()
        task.waitUntilExit()
        return task.terminationStatus
    }
}
