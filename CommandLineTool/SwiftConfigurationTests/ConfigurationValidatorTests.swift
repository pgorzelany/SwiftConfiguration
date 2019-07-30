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
    let invalidConfigurationUrl = Bundle(for: ConfigurationProviderTests.self).url(forResource: "InvalidConfiguration", withExtension: "plist")!
    lazy var configurationProvider = ConfigurationProvider()
    let validator = ConfigurationValidator()

    func testValidatingValidConfigurationFile() {
        do {
            let configurations = try configurationProvider.getConfigurations(at: validConfigurationUrl)
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
            let configurations = try configurationProvider.getConfigurations(at: validConfigurationUrl)
            try validator.validateConfigurations(configurations, activeEnvironmentName: "InvalidDev")
            XCTAssert(false, "Validation should fail")
        } catch {
            XCTAssert(true)
        }
    }

    func testValidatingInvalidConfiguration() {
        do {
            let configurations = try configurationProvider.getConfigurations(at: invalidConfigurationUrl)
            try validator.validateConfigurations(configurations, activeEnvironmentName: "InvalidDev")
            XCTAssert(false, "Validation should fail")
        } catch {
            print(error.localizedDescription)
            XCTAssert(true)
        }
    }
}
