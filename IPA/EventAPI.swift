//
//  EventAPI.swift
//  IPA
//
//  Created by Travis Werbelow on 6/11/16.
//  Copyright © 2016 Travis Werbelow. All rights reserved.
//

import Foundation
import SwiftHTTP
import JSONJoy

public class EventAPI {
    class func getEventList(callback: (Array<Event>) -> Void){
        do {
            let opt = try HTTP.GET("http://apis.mondorobot.com/events", parameters: nil, headers: nil, requestSerializer: JSONParameterSerializer())
            opt.start { response in
                if let err = response.error {
                    print("error: \(err.localizedDescription)")
                }
                
                print("EVENT finished: \(response.description)")
                do {
                    var eventArray = Array<Event>()
                    let decoder = JSONDecoder(response.data)
                    if let eventArr = decoder["events"].array {
                        for event in eventArr {
                            
                            let newEvent = try Event(event)
                            print("EVENT \(newEvent)")
                            eventArray.append(newEvent)
                        }
                    }
                    callback(eventArray)
                } catch {
                    print("Unable to parse JSON")
                }
                
            }
        } catch let error {
            print("got an error creating the request: \(error)")
        }
        
    }
    
}