//
//  SecondViewController.swift
//  greet
//
//  Created by Tyler Geery on 2/21/15.
//  Copyright (c) 2015 Geerydev. All rights reserved.
//

import UIKit

class PreferencesViewController: UIViewController {

    @IBOutlet weak var socialButton: UIButton!
    @IBOutlet weak var locationButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        socialButton.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Selected)
        locationButton.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Selected)
        socialButton.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        locationButton.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        
        socialButton.layer.borderWidth = 1
        socialButton.layer.borderColor = UIColor.blackColor().CGColor
        locationButton.layer.borderWidth = 1
        locationButton.layer.borderColor = UIColor.blackColor().CGColor

        setButtonState("default")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func setButtonSocialState(sender: AnyObject) {
        setButtonState("default")
    }
    @IBAction func setButtonLocationState(sender: AnyObject) {
        setButtonState("location")
    }
    func setButtonState(selected: String) {
        var active: UIButton
        var inactive: UIButton

        if selected == "location" {
            active = locationButton
            inactive = socialButton
        } else {
            active = socialButton
            inactive = locationButton
        }

        active.backgroundColor = UIColor.blackColor()
        inactive.backgroundColor = UIColor.whiteColor()
        
        active.selected = true
        inactive.selected = false

    }

}

