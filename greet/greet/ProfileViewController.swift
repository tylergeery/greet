//
//  ProfileViewController.swift
//  greet
//
//  Created by Tyler Geery on 2/10/15.
//  Copyright (c) 2015 Geerydev. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController, SidebarDelegate {

    var sidebar:Sidebar = Sidebar()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        sidebar = Sidebar(sourceView: self.view, menuItems: ["Explore", "Groups", "Profile", "Info", "Logout"])
        sidebar.delegate = self
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
            self.performSegueWithIdentifier("settingsToExplore", sender: self)
        break
        case 1:
            // Should go to the groups page
        break
        case 2:
            // Should go to the profile page
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
