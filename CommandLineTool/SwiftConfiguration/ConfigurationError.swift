//
//  ConfigError.swift
//  SwiftConfigCore
//
//  Created by Piotr Gorzelany on 25/04/2019.
//  Copyright © 2019 Apify. All rights reserved.
//

import Foundation

struct ConfigurationError: LocalizedError {

    private let message: String

    init(message: String) {
        self.message = message
    }

    var errorDescription: String? {
        return message
    }
}
