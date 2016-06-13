//
//  RateVC.swift
//  IPA
//
//  Created by Travis Werbelow on 6/11/16.
//  Copyright © 2016 Travis Werbelow. All rights reserved.
//

import UIKit
import RealmSwift

class RateVC: UIViewController {

    var beerToRate: BeerDetail!
    
    @IBOutlet weak var five: UIView!
    @IBOutlet weak var four: UIView!
    @IBOutlet weak var three: UIView!
    @IBOutlet weak var two: UIView!
    @IBOutlet weak var one: UIView!
    
    let realm = try! Realm()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Rate \(beerToRate.name)"
        let fiveTap = UITapGestureRecognizer(target: self, action: #selector(RateVC.rateFive))
        fiveTap.numberOfTapsRequired = 1
        self.five.userInteractionEnabled = true
        self.five.addGestureRecognizer(fiveTap)
        
        let fourTap = UITapGestureRecognizer(target: self, action: #selector(RateVC.rateFour))
        fourTap.numberOfTapsRequired = 1
        self.four.userInteractionEnabled = true
        self.four.addGestureRecognizer(fourTap)
        
        let threeTap = UITapGestureRecognizer(target: self, action: #selector(RateVC.rateThree))
        threeTap.numberOfTapsRequired = 1
        self.three.userInteractionEnabled = true
        self.three.addGestureRecognizer(threeTap)
        
        let twoTap = UITapGestureRecognizer(target: self, action: #selector(RateVC.rateTwo))
        twoTap.numberOfTapsRequired = 1
        self.two.userInteractionEnabled = true
        self.two.addGestureRecognizer(twoTap)
        
        let oneTap = UITapGestureRecognizer(target: self, action: #selector(RateVC.rateOne))
        oneTap.numberOfTapsRequired = 1
        self.one.userInteractionEnabled = true
        self.one.addGestureRecognizer(oneTap)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func rateFive(){
        print("RATE 5")
        let ratedBeer = BeerModel()
        ratedBeer.rating = 5
        ratedBeer.name = beerToRate.name
        ratedBeer.photo = beerToRate.image.original
        ratedBeer.id = beerToRate.id
        
        try! realm.write {
            realm.add(ratedBeer, update: true)
            self.navigationController?.popViewControllerAnimated(true)
            NSNotificationCenter.defaultCenter().postNotificationName("reload", object: nil)
        }
        
    }
    
    func rateFour(){
        let ratedBeer = BeerModel()
        ratedBeer.rating = 4
        ratedBeer.name = beerToRate.name
        ratedBeer.photo = beerToRate.image.original
        ratedBeer.id = beerToRate.id
        
        try! realm.write {
            realm.add(ratedBeer, update: true)
            self.navigationController?.popViewControllerAnimated(true)
            NSNotificationCenter.defaultCenter().postNotificationName("reload", object: nil)
        }
    }
    
    func rateThree(){
        let ratedBeer = BeerModel()
        ratedBeer.rating = 3
        ratedBeer.name = beerToRate.name
        ratedBeer.photo = beerToRate.image.original
        ratedBeer.id = beerToRate.id
        
        try! realm.write {
            realm.add(ratedBeer, update: true)
            self.navigationController?.popViewControllerAnimated(true)
            NSNotificationCenter.defaultCenter().postNotificationName("reload", object: nil)
        }
    }
    func rateTwo(){
        let ratedBeer = BeerModel()
        ratedBeer.rating = 2
        ratedBeer.name = beerToRate.name
        ratedBeer.photo = beerToRate.image.original
        ratedBeer.id = beerToRate.id
        
        try! realm.write {
            realm.add(ratedBeer, update: true)
            self.navigationController?.popViewControllerAnimated(true)
            NSNotificationCenter.defaultCenter().postNotificationName("reload", object: nil)
        }
    }
    func rateOne(){
        let ratedBeer = BeerModel()
        ratedBeer.rating = 1
        ratedBeer.name = beerToRate.name
        ratedBeer.photo = beerToRate.image.original
        ratedBeer.id = beerToRate.id
        
        try! realm.write {
            realm.add(ratedBeer, update: true)
            self.navigationController?.popViewControllerAnimated(true)
            NSNotificationCenter.defaultCenter().postNotificationName("reload", object: nil)
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
