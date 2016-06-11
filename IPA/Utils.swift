//
//  Utils.swift
//  IPA
//
//  Created by Travis Werbelow on 6/10/16.
//  Copyright © 2016 Travis Werbelow. All rights reserved.
//

import Foundation

class Utils {
    func createURL(url:String) -> NSURL{
        var nsurl = NSURL()
        nsurl = NSURL(string: url)!
        return nsurl
    }
    
}

extension String {
    func toDateTime() -> NSDate {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        let dateFromString : NSDate = dateFormatter.dateFromString(self)!
        return dateFromString
    }
}