//
//  Beer\.swift
//  IPA
//
//  Created by Travis Werbelow on 6/10/16.
//  Copyright © 2016 Travis Werbelow. All rights reserved.
//

import Foundation
import JSONJoy

struct Beer: JSONJoy {
    let id:String
    let name : String
    let ABV: String
    let price: String
    let image: Image
    let style: String
    
    
    init(_ decoder: JSONDecoder) throws {
        id = try decoder["id"].getString()
        name = try decoder["name"].getString()
        ABV = try decoder["abv"].getString()
        price = try decoder["price_per_glass"].getString()
        image = try Image(decoder["bottle_image"])
        style = try decoder["style"].getString()
    
    }
}