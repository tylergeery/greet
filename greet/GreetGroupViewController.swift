//
//  GreetGroupViewController.swift
//  greet
//
//  Created by Tyler Geery on 2/17/15.
//  Copyright (c) 2015 Geerydev. All rights reserved.
//

import UIKit

class GreetGroupViewController: UIViewController, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    private let reuseIdentifier = "personCell"
    var peeps:[AnyObject] = []

    @IBOutlet var collectionView: UICollectionView?

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.setNavigationBarHidden(navigationController?.navigationBarHidden == false, animated: true)

        // Do any additional setup after loading the view.
        let width: CGFloat = self.view.bounds.size.width / 2
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.itemSize = CGSize(width: width, height: 100)
        layout.minimumInteritemSpacing = 0.0;

        collectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        collectionView!.dataSource = self
        collectionView!.delegate = self
        collectionView!.registerClass(GreetGroupCollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        collectionView!.backgroundColor = UIColor.whiteColor()
        self.view.addSubview(collectionView!)
        
        var exploreRequest = NSMutableURLRequest(URL: NSURL(string: Constants.API.USER.ALL)!)
        exploreRequest.HTTPMethod = "GET"
        
        var peeps:[NSObject]
        let task = NSURLSession.sharedSession().dataTaskWithRequest(exploreRequest) {(result, response, error) in
            
            if let jsonArray = NSJSONSerialization.JSONObjectWithData(result, options: nil, error: nil) as? [NSDictionary] {
                for user in jsonArray {
                    self.peeps.append(user)
                }
                
                self.collectionView?.reloadData()
            } else {
                println("No results");
                // We should probably show a couldnt find anyone notice
            }
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

}
