//
//  PlistModifier.swift
//  SwiftConfigCore
//
//  Created by Piotr Gorzelany on 25/04/2019.
//  Copyright © 2019 Apify. All rights reserved.
//

import Foundation

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
