//
//  ViewController.swift
//  greet
//
//  Created by Tyler Geery on 2/1/15.
//  Copyright (c) 2015 Geerydev. All rights reserved.
//

import UIKit

class DefaultViewController: UIViewController, FBLoginViewDelegate {

    @IBOutlet var fbLoginView : FBLoginView!
    @IBOutlet var fbProfilePictureView : FBProfilePictureView!

    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.fbLoginView.delegate = self
        self.fbLoginView.readPermissions = ["public_profile", "email", "user_friends"]
    }
    

    // Facebook Delegate Methods
    
    func loginViewShowingLoggedInUser(loginView: FBLoginView!) {
        println("User logged in")
        println("This would be the time to perform a segue")
    }
    
    func loginViewFetchedUserInfo(loginView: FBLoginView!, user: FBGraphUser!) {
        nameLabel.text = user.name
        statusLabel.text = "Logged in as:"
        fbProfilePictureView.profileID = user.objectID?

        // Make a call to the API to store user Data
        // Do this only if we dont have a user yet
        var postLoginRequest = NSMutableURLRequest(URL: NSURL(string: Constants.API.USER.POSTLOGIN)!)
        var session = NSURLSession.sharedSession()
        var err: NSError?

        postLoginRequest.HTTPMethod = "POST"
        postLoginRequest.HTTPBody = NSJSONSerialization.dataWithJSONObject(user, options: nil, error: &err)

        let task = NSURLSession.sharedSession().dataTaskWithRequest(postLoginRequest) {(data, response, error) in
            println(NSString(data: data, encoding: NSUTF8StringEncoding))
        }

        task.resume()
    }
    
    func loginViewShowingLoggedOutUser(loginView: FBLoginView!) {
        nameLabel.text = nil
        statusLabel.text = nil
        fbProfilePictureView.profileID = nil
    }
    
    func loginView(loginView: FBLoginView!, handleError:NSError) {
        println("Error: \(handleError.localizedDescription)")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

