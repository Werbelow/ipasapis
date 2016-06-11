//
//  BeerVC.swift
//  IPA
//
//  Created by Travis Werbelow on 6/10/16.
//  Copyright © 2016 Travis Werbelow. All rights reserved.
//

import UIKit
import Kingfisher

var beerIDs = [String]()

class BeerVC: UITableViewController {

    var beerArray = Array<Beer>()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Beers"
        loadBeers()
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
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.beerArray.count
    }
    
    func loadBeers(){
        BeerAPI.getBeerList { (beers) in
            dispatch_async(dispatch_get_main_queue(), {
                self.beerArray = beers
                self.tableView.reloadData()
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
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("BeerCell", forIndexPath: indexPath) as! BeerCell
        cell.beerImage.kf_setImageWithURL(NSURL(string: beerArray[indexPath.row].image.original)!)
        cell.beerNameLabel.text = beerArray[indexPath.row].name
        cell.abvLabel.text = beerArray[indexPath.row].ABV
        cell.priceLabel.text = beerArray[indexPath.row].price
        cell.styleLabel.text = beerArray[indexPath.row].style
        return cell
        
    }

    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        beerIDs.append(self.beerArray[indexPath.row].id)
        let beerDetVC = self.storyboard?.instantiateViewControllerWithIdentifier("BeerDetailVC") as! BeerDetailVC
        self.navigationController?.pushViewController(beerDetVC, animated: true)
    }
}
