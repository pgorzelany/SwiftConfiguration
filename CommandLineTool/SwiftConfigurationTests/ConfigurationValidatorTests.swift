//
//  ConfigurationValidatorTests.swift
//  SwiftConfigurationTests
//
//  Created by pgorzelany on 30/07/2019.
//  Copyright © 2019 Apify. All rights reserved.
//

import XCTest

class ConfigurationValidatorTests: XCTestCase {

    let validConfigurationPath = Bundle(for: ConfigurationProviderTests.self).path(forResource: "ValidConfiguration", ofType: "plist")!
    let invalidConfigurationPath = Bundle(for: ConfigurationProviderTests.self).path(forResource: "InvalidConfiguration", ofType: "plist")!
    lazy var configurationProvider = ConfigurationProvider()
    let validator = ConfigurationValidator()

    func testValidatingValidConfigurationFile() {
        do {
            let configurations = try configurationProvider.getConfigurations(at: validConfigurationPath)
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
            let configurations = try configurationProvider.getConfigurations(at: validConfigurationPath)
            try validator.validateConfigurations(configurations, activeEnvironmentName: "InvalidDev")
            XCTAssert(false, "Validation should fail")
        } catch {
            XCTAssert(true)
        }
    }

    func testValidatingInvalidConfiguration() {
        do {
            let configurations = try configurationProvider.getConfigurations(at: invalidConfigurationPath)
            try validator.validateConfigurations(configurations, activeEnvironmentName: "InvalidDev")
            XCTAssert(false, "Validation should fail")
        } catch {
            print(error.localizedDescription)
            XCTAssert(true)
        }
    }
}
