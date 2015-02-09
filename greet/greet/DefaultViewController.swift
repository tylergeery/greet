//
//  ViewController.swift
//  greet
//
//  Created by Tyler Geery on 2/1/15.
//  Copyright (c) 2015 Geerydev. All rights reserved.
//

import UIKit

class DefaultViewController: UIViewController, FBLoginViewDelegate, SidebarDelegate {

    var sidebar:Sidebar = Sidebar()

    @IBOutlet var fbLoginView : FBLoginView!
    @IBOutlet var fbProfilePictureView : FBProfilePictureView!

    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.fbLoginView.delegate = self
        self.fbLoginView.readPermissions = ["public_profile", "email", "user_friends, user_photos"]
        
        sidebar = Sidebar(sourceView: self.view, menuItems: ["Explore", "Groups", "Profile", "Info"])
    }


    // Facebook Delegate Methods

    func loginViewShowingLoggedInUser(loginView: FBLoginView!) {
        // println("User logged in")
        // println("This would be the time to perform a segue")
        performSegueWithIdentifier("loggedIn", sender: self)
    }

    func loginViewFetchedUserInfo(loginView: FBLoginView!, user: FBGraphUser!) {
        nameLabel.text = user.name
        statusLabel.text = "Logged in as:"
        fbProfilePictureView.profileID = user.objectID?

        // Check User Defaults
        let userDefaults:NSUserDefaults = NSUserDefaults.standardUserDefaults()

        if(userDefaults.objectForKey("userId") == nil) {
            userDefaults.setObject(user.objectID, forKey: "userId")
            userDefaults.setObject(user.name, forKey: "name")
            userDefaults.synchronize()
            
            // Now we can do the post to API to save user data
            // Make a call to the API to store user Data
            // Do this only if we dont have a user yet
            var postLoginRequest = NSMutableURLRequest(URL: NSURL(string: Constants.API.USER.POSTLOGIN)!)
            
            postLoginRequest.HTTPMethod = "POST"
            postLoginRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
            
            var completionHandler = {
                (connection, result, error) in
                
                if let data = result["data"] as AnyObject!! {
                    let userJSONString = self.JSONStringify(user)
                    let resultJSONString = self.JSONStringify(result)
                    
                    // TODO: FIX THIS BS
                    if (!userJSONString.isEmpty && !resultJSONString.isEmpty) {
                        let postJSONString = "\(userJSONString.substringToIndex(userJSONString.endIndex.predecessor())),\(resultJSONString.substringFromIndex(resultJSONString.startIndex.successor()))"
                        
                        postLoginRequest.HTTPBody = postJSONString.dataUsingEncoding(NSUTF8StringEncoding)!
                        
                        let task = NSURLSession.sharedSession().dataTaskWithRequest(postLoginRequest) {(result, response, error) in
                            println(NSString(data: result, encoding: NSUTF8StringEncoding))
                        }
                        
                        task.resume()
                    }
                }
                
                } as FBRequestHandler;
            
            // Request the profile info
            FBRequestConnection.startWithGraphPath(
                "/me/photos",
                completionHandler: completionHandler
            );
        } else {
            // Welcome back user!
            println(userDefaults.objectForKey("userId"))
        }

        // Get the user's geographic information
    }

    func loginViewShowingLoggedOutUser(loginView: FBLoginView!) {
        nameLabel.text = nil
        statusLabel.text = nil
        fbProfilePictureView.profileID = nil
    }

    func loginView(loginView: FBLoginView!, handleError:NSError) {
        println("Error: \(handleError.localizedDescription)")
    }

    func sidebarDidSelectButtonAtPath(index: Int) {
        // Perform segue navigation
    }

    func JSONStringify(value: AnyObject) -> String {
        if NSJSONSerialization.isValidJSONObject(value) {
            if let data = NSJSONSerialization.dataWithJSONObject(value, options: nil, error: nil) {
                if let string = NSString(data: data, encoding: NSUTF8StringEncoding) {
                    return string
                }
            }
        }

        return ""
    }

    func prepForPost(value: AnyObject) -> NSData {
        let string = self.JSONStringify(value)
        return string.dataUsingEncoding(NSUTF8StringEncoding)!
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

