//
//  Settings.swift
//  catButton
//
//  Created by Sami Glasco on 6/14/15.
//  Copyright (c) 2015 Sami Glasco. All rights reserved.
//

import Foundation
import UIKit

class Settings :UIViewController {
    
    let defaults = NSUserDefaults.standardUserDefaults()
    
    @IBOutlet var ImgQuality: UISegmentedControl!
    @IBOutlet var ImgAspect: UISegmentedControl!
    
    @IBAction func ImgQualityPressed(sender: AnyObject) {
        let num = sender.selectedSegmentIndex
        defaults.setObject(num, forKey: "ImageQuality")
    }
    
    @IBAction func ImgAspect(sender: AnyObject) {
        let num = sender.selectedSegmentIndex
        defaults.setObject(num, forKey: "ImageAspect")
    }
    
    override func viewDidLoad() {
        if let qualityIndex = defaults.stringForKey("ImageQuality")
        {
            ImgQuality.selectedSegmentIndex = qualityIndex.toInt()!
        }
        
        if let aspectIndex = defaults.stringForKey("ImageAspect")
        {
            ImgAspect.selectedSegmentIndex = aspectIndex.toInt()!
        }
    }
}

