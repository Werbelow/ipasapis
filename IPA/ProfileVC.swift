//
//  ProfileVC.swift
//  IPA
//
//  Created by Travis Werbelow on 6/11/16.
//  Copyright © 2016 Travis Werbelow. All rights reserved.
//

import UIKit
import Kingfisher
import RealmSwift

private let reuseIdentifier = "ProfileRatingCell"

class ProfileVC: UICollectionViewController {
    
    var isLoggedIn:Bool = false
    let realm = try! Realm()
    var beeryArray = Array<BeerModel>()
    let beersList = try! Realm().objects(BeerModel.self).sorted("rating", ascending: false)
    
    var refresher:UIRefreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(ProfileVC.refresh), name: "reload", object: nil)
        let token = realm.addNotificationBlock { notification, realm in
            self.collectionView?.reloadData()
        }
        
        self.collectionView?.alwaysBounceVertical = true
        //pull to reresh
        refresher.addTarget(self, action: #selector(ProfileVC.refresh), forControlEvents: UIControlEvents.ValueChanged)
        refresher.backgroundColor = UIColor(red: 227/255.0, green: 27/255.0, blue:35/255.0, alpha: 1)
//        rgba(227,27,35,1)
        refresher.tintColor = .whiteColor()
        collectionView?.addSubview(refresher)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.r
    }

    //pull to refresh
    func refresh(){
        collectionView?.reloadData()
        refresher.endRefreshing()
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return beersList.count
    }

    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("ProfileRatingCell", forIndexPath: indexPath) as! ProfileRatingCell
        cell.ratingBeerImage.kf_setImageWithURL(NSURL(string: beersList[indexPath.row].photo)!)
        cell.ratingNumberLabel.text = "\(beersList[indexPath.row].rating)"
        cell.ratingBeerLabel.text = beersList[indexPath.row].name
        if beersList[indexPath.row].favorite == true {
            cell.starImage.image = UIImage(named: "unfilled-star-red")
        } else {
            cell.starImage.image = UIImage(named: "unfilled-star")
        }
        // Configure the cell
    
        return cell
    }
    
    override func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryViewOfKind(UICollectionElementKindSectionHeader, withReuseIdentifier: "ProfileHeaderVC", forIndexPath: indexPath) as! ProfileHeaderVC
        let favoreredCount = try! Realm().objects(BeerModel.self).filter("favorite == true").count
        print("FAV COUNT \(favoreredCount)")
        header.favCountLabel.text = "\(favoreredCount)"
        let ratedCount = try! Realm().objects(BeerModel.self).filter("rating > 0").count
        let ratedTotal = try! Realm().objects(BeerModel.self).filter("rating > 0")
//        var sum = 0
//        for item in ratedTotal {
//            item.rating += sum
//        }
//        var avg = sum / ratedCount
//        print("AVERAGE \(avg)")
        header.ratingCoutLabel.text = "\(ratedCount)"
        return header
        
    
    }
    

}
