//
//  GreetGroupCollectionViewController.swift
//  greet
//
//  Created by Tyler Geery on 2/9/15.
//  Copyright (c) 2015 Geerydev. All rights reserved.
//

import UIKit

let reuseIdentifier = "Cell"

class GreetGroupCollectionViewController: UICollectionViewController, SidebarDelegate {

    var sidebar:Sidebar = Sidebar()
    
    private let reuseIdentifier = "personCell"
    var peeps:[AnyObject] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        self.collectionView!.registerClass(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

        // Do any additional setup after loading the view.
        sidebar = Sidebar(sourceView: self.view, menuItems: ["Explore", "Groups", "Profile", "Info"])
        sidebar.delegate = self

        var exploreRequest = NSMutableURLRequest(URL: NSURL(string: Constants.API.USER.ALL)!)
        exploreRequest.HTTPMethod = "GET"

        var peeps:[NSObject]
        let task = NSURLSession.sharedSession().dataTaskWithRequest(exploreRequest) {(result, response, error) in
            let jsonArray = NSJSONSerialization.JSONObjectWithData(result, options: nil, error: nil) as [NSDictionary]

            for user in jsonArray {
                self.peeps.append(user)
                if let images = user["images"] as? [NSString] {
                    print(images[0])
                }
            }

            self.collectionView?.reloadData()
        }

        task.resume()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func sidebarDidSelectButtonAtPath(index: Int) {
        // Perform segue navigation
        sidebar.showSidebar(false)
        
        switch(index) {
            case 0:
                // Dont really need to do anything here
            break
            case 1:
                // Should go to the groups page
            break
            case 2:
                // Should go to the profile page
                self.performSegueWithIdentifier("exploreToSettings", sender: self)
            break;
            case 3:
                // Should go to the info page
            break
            default:
                println("Default")
        }
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
        return 1
    }


    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.peeps.count
    }

    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as GreetGroupCollectionViewCell
    
        // Configure the cell
        let imageObj:AnyObject = self.peeps[indexPath.row]
        if let images = imageObj["images"] as? [NSString] {
            if let url = NSURL(string: images[0]) {
                if let data = NSData(contentsOfURL: url){
                    cell.profilePhoto.image = UIImage(data: data)
                }
            }
        }

        if let name = imageObj["name"] as? NSString {
            cell.profileName.text = name
        }

        return cell
    }

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(collectionView: UICollectionView, shouldHighlightItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(collectionView: UICollectionView, shouldSelectItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(collectionView: UICollectionView, shouldShowMenuForItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return false
    }

    override func collectionView(collectionView: UICollectionView, canPerformAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) -> Bool {
        return false
    }

    override func collectionView(collectionView: UICollectionView, performAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) {
    
    }
    */

}
