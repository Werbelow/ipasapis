//
//  BeerDetailVC.swift
//  IPA
//
//  Created by Travis Werbelow on 6/11/16.
//  Copyright © 2016 Travis Werbelow. All rights reserved.
//

import UIKit

class BeerDetailVC: UIViewController {

    var beer:BeerDetail!
    
    @IBOutlet weak var beerImage: UIImageView!
    @IBOutlet weak var beerName: UILabel!
    @IBOutlet weak var beerStyle: UILabel!
    @IBOutlet weak var beerAbv: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.getBeer()
        let backItem = UIBarButtonItem(title: "", style: UIBarButtonItemStyle.Plain, target: nil, action: nil)
        self.navigationItem.backBarButtonItem = backItem
        self.navigationItem.backBarButtonItem?.title = ""
        self.navigationController?.navigationBar.backItem?.title = ""
        
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
                self.beer = beer
                print("BEER \(beer)")
                self.title = beer.name
                self.beerName.text = beer.name
                self.beerName.sizeToFit()
                self.beerImage.kf_setImageWithURL(NSURL(string: beer.image.original)!)
                self.beerStyle.text = beer.style
                self.beerAbv.text = beer.ABV
            })
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        var backImg: UIImage = UIImage(named: "Back-Arrow-1")!
        //        backImg = backImg.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal)
        self.navigationController?.navigationBar.backIndicatorImage = backImg
        self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = backImg
        self.navigationController?.navigationBar.tintColor = UIColor.blackColor()
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), forBarMetrics: UIBarMetrics.Default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.backgroundColor = UIColor.whiteColor()
        
    }

}
