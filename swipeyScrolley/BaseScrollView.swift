//
//  BaseScrollView.swift
//  swipeyScrolley
//
//  Created by Vmock on 07/07/16.
//  Copyright © 2016 comicsans. All rights reserved.
//

import UIKit
import Cartography
class BaseScrollView: UIScrollView {
	
	/*
	// Only override drawRect: if you perform custom drawing.
	// An empty implementation adversely affects performance during animation.
	override func drawRect(rect: CGRect) {
	// Drawing code
	}
	*/
	
	func configure(backgroundColor: UIColor, nextColor: UIColor)
	{
		contentSize = self.frame.size
		contentSize.height *= 2
		self.backgroundColor = backgroundColor
		let nextView = UIView(frame: CGRectMake(0, self.contentSize.height, superview?.frame.width ?? 0, 200))
		nextView.backgroundColor = nextColor
		self.addSubview(nextView)
		self.bounces = true
	}
	
	
}
