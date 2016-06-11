//
//  Dish.swift
//  IPA
//
//  Created by Travis Werbelow on 6/10/16.
//  Copyright © 2016 Travis Werbelow. All rights reserved.
//

import Foundation
import JSONJoy

struct Dish:JSONJoy {
    let dish:String
    
    init(_ decoder: JSONDecoder) throws {
        dish = try decoder["dish"].getString()
    }
}