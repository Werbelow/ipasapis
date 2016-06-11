//
//  ProfileVC.swift
//  IPA
//
//  Created by Travis Werbelow on 6/11/16.
//  Copyright © 2016 Travis Werbelow. All rights reserved.
//

import UIKit

class ProfileVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
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
    
    override func viewWillAppear(animated: Bool) {
        
        self.navigationController?.navigationBar.tintColor = UIColor(red: 77/255.0, green: 219/255.0, blue: 172/255.0, alpha: 1)
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), forBarMetrics: UIBarMetrics.Default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.backgroundColor = UIColor.whiteColor()
        
    }

}
