//
//  RealmModels.swift
//  IPA
//
//  Created by Travis Werbelow on 6/11/16.
//  Copyright © 2016 Travis Werbelow. All rights reserved.
//

import Foundation
import RealmSwift

class BeerModel : Object {
    dynamic var name = ""
    dynamic var id = ""
    dynamic var photo = ""
    dynamic var rating = 0
    dynamic var favorite = false
    
    override static func primaryKey() -> String? {
        return "id"
    }
}