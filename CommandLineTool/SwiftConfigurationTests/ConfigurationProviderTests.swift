//
//  ConfigurationProviderTests.swift
//  SwiftConfigurationTests
//
//  Created by pgorzelany on 30/07/2019.
//  Copyright © 2019 Apify. All rights reserved.
//

import XCTest

class ConfigurationProviderTests: XCTestCase {

    let validConfigurationPath = Bundle(for: ConfigurationProviderTests.self).path(forResource: "ValidConfiguration", ofType: "plist")!
    lazy var configurationProvider = ConfigurationProvider()

    func testParsingValidConfigurationFile() {
        do {
            let configurations = try configurationProvider.getConfigurations(at: validConfigurationPath)
            XCTAssert(configurations.count == 3, "There should be 3 configurations")
        } catch {
            XCTAssert(false, "PArsing should not fail")
        }
    }
}
