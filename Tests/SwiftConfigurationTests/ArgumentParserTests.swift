//
//  ArgumentParserTests.swift
//  SwiftConfigurationTests
//
//  Created by pgorzelany on 30/07/2019.
//  Copyright © 2019 Apify. All rights reserved.
//

import XCTest
@testable import SwiftConfiguration

class ArgumentParserTests: XCTestCase {

    let argumentParser = ArgumentsParser()

    func testParsingValidArguments() {
        let arguments = ["pwd", "/configurationplistfilepath.plist", "/outputFile.swift"]
        do {
            let _ = try argumentParser.parseArguments(arguments)
            XCTAssert(true)
        } catch {
            XCTAssert(false, error.localizedDescription)
        }
    }

    func testPArsingIncorrectNumberOfArguments() {
        let arguments = ["/configurationplistfilepath.plist", "/outputFile.swift"]
        do {
            let _ = try argumentParser.parseArguments(arguments)
            XCTAssert(false, "parser should fail")
        } catch {
            XCTAssert(true)
        }
    }
}
