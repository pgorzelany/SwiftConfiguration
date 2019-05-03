//
//  Configuration.swift
//  SwiftConfigCore
//
//  Created by Piotr Gorzelany on 25/04/2019.
//  Copyright © 2019 Apify. All rights reserved.
//

import Foundation

struct Configuration {
    let name: String
    let contents: Dictionary<String, Any>

    var allKeys: Set<String> {
        return Set(contents.keys)
    }
}
