//
//  EventVC.swift
//  IPA
//
//  Created by Travis Werbelow on 6/11/16.
//  Copyright © 2016 Travis Werbelow. All rights reserved.
//

import UIKit
import SafariServices

class EventVC: UITableViewController {

    var eventArray = Array<Event>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Events"
        loadEvents()
        
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
        return self.eventArray.count
    }

    
    func loadEvents(){
        print("LOAD EVENTS")
        EventAPI.getEventList { (events) in
            dispatch_async(dispatch_get_main_queue(), {
                self.eventArray = events
                self.tableView.reloadData()
            })
        }
    }
    
    override func viewWillAppear(animated: Bool) {
    
        self.navigationController?.navigationBar.tintColor = UIColor(red: 77/255.0, green: 219/255.0, blue: 172/255.0, alpha: 1)
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), forBarMetrics: UIBarMetrics.Default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.backgroundColor = UIColor.whiteColor()
        
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("EventCell", forIndexPath: indexPath) as! EventCell
        
        cell.eventNameLabel.text = self.eventArray[indexPath.row].title
//        let dateString = self.eventArray[indexPath.row].date
//        let date = dateString.toDateTime()
//        print("DATE! \(date)")
        cell.dateLabel.text = self.eventArray[indexPath.row].date
        cell.locationLabel.text = self.eventArray[indexPath.row].location
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if !self.eventArray[indexPath.row].url.isEmpty{
            if let url = NSURL(string: self.eventArray[indexPath.row].url) {
                let vc = SFSafariViewController(URL: url)
                presentViewController(vc, animated: true, completion: nil)
            }
        }
    }

}
