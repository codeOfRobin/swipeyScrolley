//
//  ViewController.swift
//  swipeyScrolley
//
//  Created by Vmock on 07/07/16.
//  Copyright © 2016 comicsans. All rights reserved.
//

import UIKit
class ViewController: UIViewController, UIScrollViewDelegate
{
	
	var colorArr = ["#EF9E00", "#5091D5", "#4466BD", "#2A328B", "#5E46A9", "#80197E" , "#AE1E5F"].map{return UIColor(hexString:$0)}.sort { (color1, color2) -> Bool in
		var hue1: CGFloat = 0
		var hue2: CGFloat = 0
		color1.getHue(&hue1, saturation: nil, brightness: nil, alpha: nil)
		color2.getHue(&hue2, saturation: nil, brightness: nil, alpha: nil)
		return hue1 < hue2
	}
	
	var currentIndex = 0
	var prevScrollView:BaseScrollView?
	var currentScrollView:BaseScrollView?
	var nextScrollView:BaseScrollView?
	let flatObjArray = Array(1...5)
	override func viewDidLoad()
	{
		super.viewDidLoad()
		currentScrollView = BaseScrollView(frame: view.frame)
		view.addSubview(currentScrollView!)
		currentScrollView?.configure(colorArr[0], nextColor: colorArr[1])
		currentScrollView?.delegate = self
		
		nextScrollView = BaseScrollView(frame: view.frame)
		nextScrollView?.frame.origin.y += view.frame.size.height
		view.addSubview(nextScrollView!)
		nextScrollView?.configure(colorArr[currentIndex + 1], nextColor: colorArr[currentIndex + 2])
		nextScrollView?.delegate = self
		// Do any additional setup after loading the view.
	}
	
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
	
	func scrollViewDidEndDragging(scrollView: UIScrollView, willDecelerate decelerate: Bool)
	{
		if scrollView.contentOffset.y + scrollView.frame.height > 40 + scrollView.contentSize.height
		{
			let overscroll = scrollView.contentOffset.y + scrollView.frame.height - scrollView.contentSize.height
			self.nextScrollView?.frame.origin.y -= overscroll
			UIView.animateWithDuration(0.5, animations:
				{
					//TODO: Understand that -= is a bracket around the thing on the right hand side
					self.nextScrollView?.frame.origin.y -= self.view.frame.height - overscroll
					self.prevScrollView?.frame.origin.y -= self.view.frame.height
					
				}, completion:
				{ (completed) in
					self.prevScrollView?.removeFromSuperview()
					//TODO: Premature optimisation is the root of all evil. Pliss to look at context
					//					self.prevScrollView = nil
					self.prevScrollView = self.currentScrollView
					//					self.currentScrollView = nil
					self.currentScrollView = self.nextScrollView
					//					self.nextScrollView = nil
					if self.currentIndex != self.flatObjArray.count - 1
					{
						self.currentIndex += 1
						self.nextScrollView = BaseScrollView(frame: self.view.frame)
						self.nextScrollView?.frame.origin.y += self.view.frame.height
						self.view.addSubview(self.nextScrollView!)
						self.nextScrollView?.configure(self.colorArr[self.currentIndex + 1], nextColor: self.colorArr[self.currentIndex + 2])
						self.nextScrollView?.delegate = self
					}
					
			})
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

