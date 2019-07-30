//
//  ConfigurationValidatorTests.swift
//  SwiftConfigurationTests
//
//  Created by pgorzelany on 30/07/2019.
//  Copyright © 2019 Apify. All rights reserved.
//

import XCTest

class ConfigurationValidatorTests: XCTestCase {

    let validConfigurationUrl = Bundle(for: ConfigurationProviderTests.self).url(forResource: "ValidConfiguration", withExtension: "plist")!
    lazy var configurationProvider = ConfigurationProvider(configurationPlistFileUrl: validConfigurationUrl)
    let validator = ConfigurationValidator()

    func testValidatingValidConfigurationFile() {
        do {
            let configurations = try configurationProvider.getConfigurations()
            let validEnvironments = ["Dev", "Test", "Staging"]
            for environment in validEnvironments {
                try validator.validateConfigurations(configurations, activeEnvironmentName: environment)
                XCTAssert(true)
            }
        } catch {
            XCTAssert(false, "PArsing should not fail")
        }
    }

    func testValidingValidConfigurationFileWithInvalidEnvironment() {
        do {
            let configurations = try configurationProvider.getConfigurations()
            try validator.validateConfigurations(configurations, activeEnvironmentName: "InvalidDev")
            XCTAssert(false, "Validation should fail")
        } catch {
            XCTAssert(true)
        }
    }
}
