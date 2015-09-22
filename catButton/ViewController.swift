//
//  ViewController.swift
//  catButton
//
//  Created by Sami Glasco on 6/13/15.
//  Copyright (c) 2015 Sami Glasco. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
	
	
	var imgSource = String()
	var imageAspect = UIViewContentMode.ScaleAspectFit
	var catImage = UIImage()
	var nextImage = UIImage()
	let defaults = NSUserDefaults.standardUserDefaults()
	
	@IBOutlet var cat: UIImageView!
	@IBOutlet var catbg: UIImageView!
	
	@IBOutlet var catButton: UIButton!
	
	//button to load new picture
	@IBAction func catButton(sender: AnyObject) {
		setImage()
		preloadImage()
	}
	
	//share button
	@IBAction func shareButton(sender: AnyObject) {
		let objectsToShare = [self.catImage]
		let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
		self.presentViewController(activityVC, animated: true, completion: nil)
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		firstLoad()
	}
	
	//sets image aspect on view load
	override func viewWillAppear(animated: Bool) {
		if let aspectIndex = defaults.stringForKey("ImageAspect")
		{
			setImageFit(Int(aspectIndex)!)
		}
		self.cat.contentMode = self.imageAspect
	}
	
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
	
	//retrieves image data from URL using TheCatAPI
	func getDataFromUrl(url:NSURL, completion: ((data: NSData?, error: NSError!) -> Void)) {

		UIApplication.sharedApplication().networkActivityIndicatorVisible = true
		NSURLSession.sharedSession().dataTaskWithURL(url) { (data, response, error) in
			completion(data: data, error: error)
			if let httpResponse = response as? NSHTTPURLResponse {
				self.imgSource = httpResponse.URL!.absoluteString
			}
			UIApplication.sharedApplication().networkActivityIndicatorVisible = false
			}.resume()
		
	}
	
	//sets the UIImage using data from getDataFromUrl
	func setImage(){
		self.catImage = self.nextImage
		
		dispatch_async(dispatch_get_main_queue()) {
			self.cat.contentMode = self.imageAspect
			self.cat.image = self.catImage
			self.catbg.image = self.catImage
			
		}
	}
	
	//preloads the next image
	func preloadImage(){
		let url = NSURL(string: "http://thecatapi.com/api/images/get?format=src&type=jpg,png&API_key=MjEzODM&size=full")
		getDataFromUrl(url!) {  (data, error) in
			//no internet check
			if((error) != nil){
				self.nextImage = UIImage(named: "nointernet")!
			} else {
				self.nextImage = UIImage(data: data!)!
			}
		}
		
	}
	
	//loads the very first image
	func firstLoad(){
		let url = NSURL(string: "http://thecatapi.com/api/images/get?format=src&type=jpg,png&API_key=MjEzODM&size=full")
		getDataFromUrl(url!) {  (data, error) in
			//no internet check
			if((error) != nil){
				self.catImage = UIImage(named: "nointernet")!
			} else {
				self.catImage = UIImage(data: data!)!
			}
			
			dispatch_async(dispatch_get_main_queue()) {
				self.cat.contentMode = self.imageAspect
				self.cat.image = self.catImage
				self.catbg.image = self.catImage
			}
		}
		preloadImage()
	}
	
	//changes the image aspect size
	func setImageFit(aspect: IntegerLiteralType){
		if (aspect == 0){
			self.imageAspect = UIViewContentMode.ScaleAspectFill
		} else {
			self.imageAspect = UIViewContentMode.ScaleAspectFit
		}
	}
	
	//doesn't work TODO :C
	func shareSource() -> NSString{
		print(imgSource)
		print("testing")
		return self.imgSource
	}
	
}