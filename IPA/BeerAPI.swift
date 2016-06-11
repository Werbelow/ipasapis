//
//  BeerAPI.swift
//  IPA
//
//  Created by Travis Werbelow on 6/10/16.
//  Copyright © 2016 Travis Werbelow. All rights reserved.
//

import Foundation
import SwiftHTTP
import JSONJoy

public class BeerAPI {
    class func getBeerList(callback: (Array<Beer>) -> Void){
        do {
            let opt = try HTTP.GET("http://apis.mondorobot.com/beers", parameters: nil, headers: nil, requestSerializer: JSONParameterSerializer())
            opt.start { response in
                if let err = response.error {
                    print("error: \(err.localizedDescription)")
                }
                
                print("opt finished: \(response.description)")
                do {
                    var beerArray = Array<Beer>()
                    let decoder = JSONDecoder(response.data)
                    print("decoder \(decoder["beers"].array)")
                    if let beerArr = decoder["beers"].array {
                        for beer in beerArr {
                            
                            let newBeer = try Beer(beer)
                            print("Beer \(newBeer)")
                            beerArray.append(newBeer)
                        }
                    }
                    callback(beerArray)
                } catch {
                    print("Unable to parse JSON")
                }
                
            }
        } catch let error {
            print("got an error creating the request: \(error)")
        }
        
    }
    
    class func getBeerDetail(id: String, callback: (BeerDetail) -> Void){
        do {
            let opt = try HTTP.GET("http://apis.mondorobot.com/beers/\(id)", parameters: nil, headers: nil, requestSerializer: JSONParameterSerializer())
            opt.start { response in
                if let err = response.error {
                    print("error: \(err.localizedDescription)")
                }
                
                print("opt finished: \(response.description)")
                do {
                    let decoder = JSONDecoder(response.data)
                    let beer = try BeerDetail(decoder["beer"])
                    
                    callback(beer)
                } catch {
                    print("Unable to parse JSON")
                }
                
            }
        } catch let error {
            print("got an error creating the request: \(error)")
        }
        
    }
    
}