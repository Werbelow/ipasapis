//
//  Location.swift
//  IPA
//
//  Created by Travis Werbelow on 6/11/16.
//  Copyright © 2016 Travis Werbelow. All rights reserved.
//

import Foundation
import JSONJoy

struct Location: JSONJoy {
    let name:String
    let address: Address
    let phone:String
    
    init(_ decoder: JSONDecoder) throws {
        name = try decoder["name"].getString()
        address = try Address(decoder["address"])
        phone = try decoder["phone"].getString()
    }
    
}