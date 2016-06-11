//
//  Event.swift
//  IPA
//
//  Created by Travis Werbelow on 6/11/16.
//  Copyright © 2016 Travis Werbelow. All rights reserved.
//

import Foundation
import JSONJoy

struct Event:JSONJoy {
    let id:String
    let title:String
    let date:String
    let location:String
    let url:String
    
    init(_ decoder: JSONDecoder) throws {
        id = try decoder["id"].getString()
        title = try decoder["title"].getString()
        date = try decoder["starts_at"].getString()
        location = try decoder["location"].getString()
        url = try decoder["ticket_url"].getString()
    }
    
}