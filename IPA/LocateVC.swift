//
//  LocateVC.swift
//  IPA
//
//  Created by Travis Werbelow on 6/11/16.
//  Copyright © 2016 Travis Werbelow. All rights reserved.
//

import UIKit

class LocateVC: UITableViewController {

    var locationArray = Array<Location>()
    
    var zipcode = ""
    var beerName = ""
    var beerID = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadLocations()
        self.title = "\(beerName) around \(zipcode)"
        let backItem = UIBarButtonItem(title: "", style: UIBarButtonItemStyle.Plain, target: nil, action: nil)
        self.navigationItem.backBarButtonItem = backItem
        self.navigationItem.backBarButtonItem?.title = ""
        self.navigationController?.navigationBar.backItem?.title = ""
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
        return self.locationArray.count
    }
    
    func loadLocations(){
        BeerAPI.getBeerLocations(beerID, zipcode: zipcode) { (locations) in
            dispatch_async(dispatch_get_main_queue(), {
                self.locationArray = locations
                self.tableView.reloadData()
            })
            
        }
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("LocateCell", forIndexPath: indexPath) as! LocateCell
        cell.nameLabel.text = self.locationArray[indexPath.row].name
        cell.streetLabel.text = self.locationArray[indexPath.row].address.street
        cell.cityLabel.text = self.locationArray[indexPath.row].address.city
        cell.stateLabel.text = self.locationArray[indexPath.row].address.state
        cell.zipLabel.text = self.locationArray[indexPath.row].address.zip
        
        return cell
        
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let cell = tableView.dequeueReusableCellWithIdentifier("LocateCell", forIndexPath: indexPath) as! LocateCell
        let street = self.locationArray[indexPath.row].address.street
        let city = self.locationArray[indexPath.row].address.city
        let state = self.locationArray[indexPath.row].address.state
        let zip = self.locationArray[indexPath.row].address.zip
        
        let addressString = street + " " + city + " " + state + " " + zip
        print("addressString \(addressString)")
        
        let vc = self.storyboard?.instantiateViewControllerWithIdentifier("MapVC") as! MapVC
        vc.addressString = addressString
        vc.locationName = self.locationArray[indexPath.row].name
        self.navigationController?.pushViewController(vc, animated: true)
        
    }



}
