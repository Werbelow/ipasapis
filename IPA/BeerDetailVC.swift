//
//  BeerDetailVC.swift
//  IPA
//
//  Created by Travis Werbelow on 6/11/16.
//  Copyright © 2016 Travis Werbelow. All rights reserved.
//

import UIKit
import CoreLocation
import RealmSwift

class BeerDetailVC: UIViewController, CLLocationManagerDelegate {

    var newBeer:BeerDetail!
    
    @IBOutlet weak var beerImage: UIImageView!
    @IBOutlet weak var beerName: UILabel!
    @IBOutlet weak var beerStyle: UILabel!
    @IBOutlet weak var beerAbv: UILabel!
    @IBOutlet weak var beerDescriptionLabel: UILabel!
    @IBOutlet weak var foodPairingLabel: UILabel!
    @IBOutlet weak var pairsWellWith: UILabel!
    @IBOutlet weak var favIcon: UIImageView!
    @IBOutlet weak var heartIcon: UIImageView!
    
    @IBOutlet weak var locateIcon: UIImageView!
    @IBOutlet weak var descriptorsLabel: UILabel!
    
    var willSegue:Bool = false
    
    var zipCode = ""
    
    let realm = try! Realm()
    
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.getBeer()
        let backItem = UIBarButtonItem(title: "", style: UIBarButtonItemStyle.Plain, target: nil, action: nil)
        self.navigationItem.backBarButtonItem = backItem
        self.navigationItem.backBarButtonItem?.title = ""
        self.navigationController?.navigationBar.backItem?.title = ""
        let tap = UITapGestureRecognizer(target: self, action: #selector(BeerDetailVC.findLocation))
        tap.numberOfTapsRequired = 1
        self.locateIcon.userInteractionEnabled = true
        self.locateIcon.addGestureRecognizer(tap)
        
        let favTap = UITapGestureRecognizer(target: self, action: #selector(BeerDetailVC.favBeer))
        favTap.numberOfTapsRequired = 1
        self.favIcon.userInteractionEnabled = true
        self.favIcon.addGestureRecognizer(favTap)
        
        let rateTap = UITapGestureRecognizer(target: self, action: #selector(BeerDetailVC.rateBeer))
        rateTap.numberOfTapsRequired = 1
        self.heartIcon.userInteractionEnabled = true
        self.heartIcon.addGestureRecognizer(rateTap)
        
        if let navigationController = self.navigationController {
            
            let navigationBar = navigationController.navigationBar
            let navBorder: UIView = UIView(frame: CGRectMake(0, navigationBar.frame.size.height - 1, navigationBar.frame.size.width, 1))
            // Set the color you want here
            navBorder.backgroundColor = UIColor(red: 247/255.0, green: 247/255.0, blue: 249/255.0, alpha: 1)
            navBorder.opaque = true
            self.navigationController?.navigationBar.addSubview(navBorder)
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getBeer(){
        BeerAPI.getBeerDetail(beerIDs.last!) { (beer) in
            dispatch_async(dispatch_get_main_queue(), {
                self.newBeer = beer
                print("BEER \(beer)")
                self.title = beer.name
                self.beerName.text = beer.name
                self.beerName.sizeToFit()
                self.beerImage.kf_setImageWithURL(NSURL(string: beer.image.original)!)
                self.beerStyle.text = beer.style
                self.beerAbv.text = beer.ABV
                self.beerDescriptionLabel.text = beer.description
                self.beerDescriptionLabel.sizeToFit()
                self.beerDescriptionLabel.layoutIfNeeded()
                self.descriptorsLabel.text = beer.descriptors.joinWithSeparator(", ")
                self.descriptorsLabel.sizeToFit()
                self.descriptorsLabel.layoutIfNeeded()
                if !beer.foodPairings.isEmpty {
                    self.pairsWellWith.hidden = false
                    self.foodPairingLabel.hidden = false
                    self.foodPairingLabel.text = beer.foodPairings[0].dish
                } else {
                    self.pairsWellWith.hidden = true
                    self.foodPairingLabel.hidden = true
                }
                
            })
        }
    }
    
    func favBeer(){
        let ratedBeer = BeerModel()
        ratedBeer.name = newBeer.name
        ratedBeer.photo = newBeer.image.original
        ratedBeer.id = newBeer.id
        ratedBeer.favorite = true
        
        try! realm.write {
            realm.add(ratedBeer, update: true)
            self.favIcon.image = UIImage(named: "unfilled-star-red")
            NSNotificationCenter.defaultCenter().postNotificationName("reload", object: nil)
        }
    }
    
    func rateBeer(){
        print("RATE BEER")
        let vc = self.storyboard?.instantiateViewControllerWithIdentifier("RateVC") as! RateVC
        vc.beerToRate = newBeer
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    override func viewWillAppear(animated: Bool) {
        beerDescriptionLabel.layoutIfNeeded()
        self.willSegue = false
        var backImg: UIImage = UIImage(named: "Back-Arrow-1")!
        //        backImg = backImg.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal)
        self.navigationController?.navigationBar.backIndicatorImage = backImg
        self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = backImg
        self.navigationController?.navigationBar.tintColor = UIColor.blackColor()
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), forBarMetrics: UIBarMetrics.Default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.backgroundColor = UIColor.whiteColor()
        
    }
    
    func findLocation(){
        print("FIND LOCATION")
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        CLGeocoder().reverseGeocodeLocation(manager.location!) { (placemarks, error) in
            self.locationManager.stopUpdatingLocation()
            if placemarks!.count > 0 && self.willSegue == false {
                self.willSegue = true
                print("ZIP CODE \((placemarks!.last! as CLPlacemark).postalCode!)")
                self.zipCode = (placemarks!.last! as CLPlacemark).postalCode!
                self.findBeer()
            }
        }
    }
    
    
    func findBeer() {
        let vc = self.storyboard?.instantiateViewControllerWithIdentifier("LocateVC") as! LocateVC
        vc.beerID = self.newBeer.id
        vc.zipcode = self.zipCode
        vc.beerName = self.newBeer.name
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError!) {
        
    }

}
