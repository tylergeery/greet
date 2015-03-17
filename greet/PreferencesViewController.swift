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

    @IBOutlet weak var socialView: UIView!
    @IBOutlet weak var locationView: UIView!

    @IBOutlet weak var barPreferenceView: UIView!
    @IBOutlet weak var barPreferenceButton: UIButton!

    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var locationSlider: UISlider!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        locationView.hidden = true;

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
        setPreferencesView("social")
    }
    @IBAction func setButtonLocationState(sender: AnyObject) {
        setButtonState("location")
        setPreferencesView("location")
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

    @IBAction func barPreferenceButtonPressed(sender: AnyObject) {
        let startingPosition = self.barPreferenceButton.frame.origin.x
        let offset = (startingPosition > 0) ? 0 : self.barPreferenceView.frame.size.width - self.barPreferenceButton.frame.size.width
        println("view width: \(startingPosition), offset: \(offset)")
        UIView.animateWithDuration(1, animations: {
            self.barPreferenceButton.frame.origin = CGPoint(x: offset, y: self.barPreferenceButton.frame.origin.y)
            }, completion: { (Value: Bool) in
                println("completed now do something else")
        })
    }
    @IBAction func locationPreferenceChanged(sender: AnyObject) {
        let dist = String(Int(self.locationSlider.value))
        self.locationLabel.text = (dist == "50") ? "50+ mi" : dist + " mi"
    }
    func setPreferencesView(selected: String) {
        if selected == "location" {
            self.locationView.hidden = false
            self.socialView.hidden = true
        } else {
            self.locationView.hidden = true
            self.socialView.hidden = false
        }
    }
}

