//
//  TabBarVC.swift
//  IPA
//
//  Created by Travis Werbelow on 6/11/16.
//  Copyright © 2016 Travis Werbelow. All rights reserved.
//

import UIKit

class TabBarVC: UITabBarController, UITabBarControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        self.tabBar.translucent = true
        self.tabBar.tintColor = UIColor(red: 227/255.0, green: 27/255.0, blue: 35/255.0, alpha: 1)
        self.tabBar.layer.borderColor = UIColor(red: 247/255.0, green: 247/255.0, blue: 249/255.0, alpha: 1).CGColor
        self.tabBar.layer.borderWidth = 1
        self.tabBar.clipsToBounds = true
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    var previousController = UIViewController()
    
    func tabBarController(tabBarController: UITabBarController, didSelectViewController viewController: UIViewController) {
        print("DID SELECT VC")
        if previousController == viewController {
            print("PREV VC == VC")
            if let navVC = viewController as? UINavigationController, vc = navVC.viewControllers.first as? UITableViewController {
                print("SHOULD SCROLL TO TOP")
                //                vc.tableView?.setContentOffset(CGPointMake(0.0, -44), animated: true)
                vc.tableView.layoutIfNeeded()
                vc.tableView.setNeedsLayout()
                let indexPath = NSIndexPath(forRow: 0, inSection: 0)
                vc.tableView.scrollToRowAtIndexPath(indexPath, atScrollPosition: .Top, animated: true)
                //                vc.tableView.setContentOffset(CGPointMake(0.0, 0.0), animated: true)
                
            }
        }
        previousController = viewController;
        
    }
}
