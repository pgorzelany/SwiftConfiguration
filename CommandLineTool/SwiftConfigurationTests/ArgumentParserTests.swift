//
//  ArgumentParserTests.swift
//  SwiftConfigurationTests
//
//  Created by pgorzelany on 30/07/2019.
//  Copyright © 2019 Apify. All rights reserved.
//

import XCTest

class ArgumentParserTests: XCTestCase {

    let argumentParser = ArgumentsParser()

    func testParsingValidArguments() {
        let arguments = ["pwd", "/plistfilepath.plist", "/configurationplistfilepath.plist", "/outputFile.swift", "Dev"]
        do {
            let _ = try argumentParser.parseArguments(arguments)
            XCTAssert(true)
        } catch {
            XCTAssert(false, error.localizedDescription)
        }
    }

    func testPArsingInvalidUrls() {
        let invalidArguments = [
            ["pwd", "not a file path", "/configurationplistfilepath.plist", "/outputFile.swift", "Dev"],
            ["pwd", "/plistfilepath.plist", "123 567", "/outputFile.swift", "Dev"],
            ["pwd", "/plistfilepath.plist", "/configurationplistfilepath.plist", "check12wha tisthis?", "Dev"]
        ]
        for arguments in invalidArguments {
            do {
                let _ = try argumentParser.parseArguments(arguments)
                XCTAssert(false, "parser should fail")
            } catch {
                XCTAssert(true)
            }
        }
    }

    func testPArsingIncorrectNumberOfArguments() {
        let arguments = ["/plistfilepath.plist", "/configurationplistfilepath.plist", "/outputFile.swift", "Dev"]
        do {
            let _ = try argumentParser.parseArguments(arguments)
            XCTAssert(false, "parser should fail")
        } catch {
            XCTAssert(true)
        }
    }
}
