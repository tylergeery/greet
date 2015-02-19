//
//  GreetGroupViewController.swift
//  greet
//
//  Created by Tyler Geery on 2/17/15.
//  Copyright (c) 2015 Geerydev. All rights reserved.
//

import UIKit

class GreetGroupViewController: UIViewController, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, SidebarDelegate {

    var sidebar:Sidebar = Sidebar()
    
    private let reuseIdentifier = "personCell"
    var peeps:[AnyObject] = []

    @IBOutlet var collectionView: UICollectionView?

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.setNavigationBarHidden(navigationController?.navigationBarHidden == false, animated: true)

        // Do any additional setup after loading the view.
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 20, left: 10, bottom: 10, right: 10)
        layout.itemSize = CGSize(width: 90, height: 90)

        collectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        collectionView!.dataSource = self
        collectionView!.delegate = self
        collectionView!.registerClass(GreetGroupCollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        collectionView!.backgroundColor = UIColor.whiteColor()
        self.view.addSubview(collectionView!)
        
        // Get the people resources
        sidebar = Sidebar(sourceView: self.view, menuItems: ["Explore", "Groups", "Profile", "Info", "Logout"])
        sidebar.delegate = self
        
        var exploreRequest = NSMutableURLRequest(URL: NSURL(string: Constants.API.USER.ALL)!)
        exploreRequest.HTTPMethod = "GET"
        
        var peeps:[NSObject]
        let task = NSURLSession.sharedSession().dataTaskWithRequest(exploreRequest) {(result, response, error) in
            
            let jsonArray = NSJSONSerialization.JSONObjectWithData(result, options: nil, error: nil) as [NSDictionary]
            
            for user in jsonArray {
                self.peeps.append(user)
            }

            self.collectionView?.reloadData()
            println("peeps loaded")
        }
        
        task.resume()

    }

    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        println(self.peeps.count)
        return self.peeps.count > 0 ? self.peeps.count : 20
    }

    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as GreetGroupCollectionViewCell

        if self.peeps.count > indexPath.row {
            let person:AnyObject = self.peeps[indexPath.row]
            if let image = person["image"] as? NSString {
                println(image)
                let url = NSURL(string: image)
                let data = NSData(contentsOfURL: url!)
                cell.imageView.image = UIImage(data: data!)
            }

            cell.textLabel?.text = person["name"] as? NSString
        }

        cell.textLabel.textColor = UIColor.blackColor()
        return cell
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */


    // MARK: Sidebar Navigation
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
        break
        case 3:
            // Should go to the info page
        break
        case 4:
            FBSession.activeSession().closeAndClearTokenInformation()
        break
        default:
            println("Default")
        }
    }

}
