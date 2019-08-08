//
//  ViewController.swift
//  Example
//
//  Created by Piotr Gorzelany on 03/05/2019.
//  Copyright © 2019 Apify. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        let swiftConfiguration = SwiftConfiguration.current
        for key in SwiftConfiguration.ConfigurationKey.allCases {
            print(swiftConfiguration.value(for: key))
        }
    }


}

