//
//  ConfigurationValidator.swift
//  SwiftConfigCore
//
//  Created by Piotr Gorzelany on 25/04/2019.
//  Copyright © 2019 Apify. All rights reserved.
//

import Foundation

class ConfigurationValidator {

    // MARK: - Properties

    private let activeEnvironmentName: String

    // MARK: - Lifecycle

    init(activeEnvironmentName: String) {
        self.activeEnvironmentName = activeEnvironmentName
    }

    // MARK: - Public Methods

    func validateConfigurations(_ configurations: [Configuration]) throws {
        let allKeys = configurations.reduce(Set<String>(), { (result, configuration) -> Set<String> in
                return result.union(configuration.allKeys)
            })
        for configuration in configurations {
            let difference = allKeys.subtracting(configuration.allKeys)
            if !difference.isEmpty {
                var warning = ""
                for key in difference {
                    warning += "warning: missing key: \(key) in configuration: \(configuration.name)"
                }
                throw ConfigurationError(message: warning)
            }
        }

        let configurationNames = configurations.map({$0.name})

        guard configurationNames.contains(where: {[weak self] in $0 == self?.activeEnvironmentName}) else {
            throw ConfigurationError(message: "error: The configuration file does not contain a configuration for the active configuration (\(activeEnvironmentName))")
        }
    }
}
