//
//  BeerDetail.swift
//  IPA
//
//  Created by Travis Werbelow on 6/10/16.
//  Copyright © 2016 Travis Werbelow. All rights reserved.
//

import Foundation
import JSONJoy

struct BeerDetail: JSONJoy {
    let description : String
    let descriptors: Array<String>
    let foodPairings: Array<Dish>
    let relatedBeers: Array<Beer>
    let name : String
    let ABV: String
    let price: String
    let image: Image
    let style: String
    
    
    
    init(_ decoder: JSONDecoder) throws {
        description = try decoder["description"].getString()
        guard let descriptorsArray = decoder["descriptors"].array else {throw JSONError.WrongType}
        var tempArray = Array<String>()
        for descriptor in descriptorsArray {
            tempArray.append(try JSONDecoder(descriptor).getString())
        }
        descriptors = tempArray
        print("DESCRIPTORS \(descriptors)")
        guard let foodArray = decoder["food_pairings"].array else {throw JSONError.WrongType}
        var foodTempArray = Array<Dish>()
        for food in foodArray {
            foodTempArray.append(try Dish(food))
        }
        foodPairings = foodTempArray
        print("FOOD PAIRINGS \(foodPairings)")
        guard let beerArray = decoder["related_beers"].array else {throw JSONError.WrongType}
        var beerTempArray = Array<Beer>()
        for beer in beerArray {
            beerTempArray.append(try Beer(beer))
        }
        relatedBeers = beerTempArray
        print("RELATED BEERS \(relatedBeers)")
        name = try decoder["name"].getString()
        ABV = try decoder["abv"].getString()
        price = try decoder["price_per_glass"].getString()
        image = try Image(decoder["bottle_image"])
        style = try decoder["style"].getString()
        
        
    }
}