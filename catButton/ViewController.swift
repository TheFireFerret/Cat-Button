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
	
	var imgSource = NSString()
	var imageAspect = UIViewContentMode.ScaleAspectFit
	var imageQual = "med"
	var catImage = UIImage()
	let defaults = NSUserDefaults.standardUserDefaults()
	
	@IBOutlet var cat: UIImageView!
	@IBOutlet var catbg: UIImageView!
	
	@IBAction func catButton(sender: AnyObject) {
		setImage()
	}
	
	//button to load new cat picture
	@IBAction func shareButton(sender: AnyObject) {
		let objectsToShare = [self.catImage]
		let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
		self.presentViewController(activityVC, animated: true, completion: nil)
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		setImage()
	}
	
	override func viewWillAppear(animated: Bool) {
		if let aspectIndex = defaults.stringForKey("ImageAspect"), qualIndex = defaults.stringForKey("ImageQuality")
		{
			setImageFit(aspectIndex.toInt()!)
//			println("testwillappear?")
			setImageQuality(qualIndex.toInt()!)
		}
	}
	
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
	
	//retrieves image data from URL with TheCatAPI
	func getDataFromUrl(url:NSURL, completion: ((data: NSData?, error: NSError!) -> Void)) {
		var sourceURL = url
		UIApplication.sharedApplication().networkActivityIndicatorVisible = true
		NSURLSession.sharedSession().dataTaskWithURL(url) { (data, response, error) in
			completion(data: data, error: error)
			if let httpResponse = response as? NSHTTPURLResponse {
				self.imgSource = httpResponse.URL!.absoluteString!
			}
			UIApplication.sharedApplication().networkActivityIndicatorVisible = false
			}.resume()
	}
	
	//sets the UIImage using data from getDataFromUrl
	func setImage(){
		let url = NSURL(string: "http://thecatapi.com/api/images/get?format=src&type=jpg,png&API_key=MjEzODM&size=" + imageQual)
		//		println(url)
		getDataFromUrl(url!) {  (data, error) in
			//no internet?
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
	}
	
	//changes the image aspect size
	func setImageFit(aspect: IntegerLiteralType){
		if (aspect == 0){
			self.imageAspect = UIViewContentMode.ScaleAspectFill
//			println("fill")
		} else {
			self.imageAspect = UIViewContentMode.ScaleAspectFit
//			println("fit")
		}
	}
	
	//changes the image url to change image quality
	func setImageQuality(qual: IntegerLiteralType){
		if (qual == 2){
			self.imageQual = "full"
		} else if (qual == 1){
			self.imageQual = "med"
		} else {
			self.imageQual = "small"
		}
	}
	
}