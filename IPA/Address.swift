//
//  Address.swift
//  IPA
//
//  Created by Travis Werbelow on 6/11/16.
//  Copyright © 2016 Travis Werbelow. All rights reserved.
//

import Foundation
import JSONJoy

struct Address: JSONJoy {
    let street:String
    let city:String
    let state:String
    let zip:String
    
    init(_ decoder: JSONDecoder) throws {
        street = try decoder["street"].getString()
        city = try decoder["city"].getString()
        state = try decoder["state"].getString()
        zip = try decoder["zip"].getString()
    }
}