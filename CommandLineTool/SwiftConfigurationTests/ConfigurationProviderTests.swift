//
//  ConfigurationProviderTests.swift
//  SwiftConfigurationTests
//
//  Created by pgorzelany on 30/07/2019.
//  Copyright © 2019 Apify. All rights reserved.
//

import XCTest

class ConfigurationProviderTests: XCTestCase {

    let validConfigurationUrl = Bundle(for: ConfigurationProviderTests.self).url(forResource: "ValidConfiguration", withExtension: "plist")!
    lazy var configurationProvider = ConfigurationProvider(configurationPlistFileUrl: validConfigurationUrl)

    func testParsingValidConfigurationFile() {
        do {
            let configurations = try configurationProvider.getConfigurations()
            XCTAssert(configurations.count == 3, "There should be 3 configurations")
        } catch {
            XCTAssert(false, "PArsing should not fail")
        }
    }
}
