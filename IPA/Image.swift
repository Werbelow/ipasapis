//
//  Image.swift
//  IPA
//
//  Created by Travis Werbelow on 6/10/16.
//  Copyright © 2016 Travis Werbelow. All rights reserved.
//

import Foundation
import JSONJoy

struct Image:JSONJoy{
    let original:String
    
    init(_ decoder: JSONDecoder) throws {
        original = try decoder["original"].getString()
    }
}