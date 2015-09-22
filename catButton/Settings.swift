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
	
	//persistent settings using NSUserDefaults
    let defaults = NSUserDefaults.standardUserDefaults()
	var src = ""
	
    @IBOutlet var ImgAspect: UISegmentedControl!

	@IBOutlet weak var sourceurl: UILabel!
	
    @IBAction func ImgAspect(sender: AnyObject) {
        let num = sender.selectedSegmentIndex
        defaults.setObject(num, forKey: "ImageAspect")
    }
    
    override func viewDidLoad() {
		super.viewDidLoad()
        if let aspectIndex = defaults.stringForKey("ImageAspect")
        {
            ImgAspect.selectedSegmentIndex = Int(aspectIndex)!
        }
	}
//	
//	override func viewWillAppear(animated: Bool) {
//		super.viewWillAppear(animated)
//		sourceurl.text = self.src
//		print("1:  " + self.src)
//		print("i'm here")
//	}
//	
//	func setSource(url:String){
////		sourceurl.text = url as String
//		self.src = url
//		print("url: " + url)
//		print("src" + self.src)
//	}
}

