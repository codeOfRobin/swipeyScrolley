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
	
    let dummyViewMargin:CGFloat = 20.0
    let dummyViewHeight:CGFloat = 256
    var childrenViews:[UIView] = []
    
	func configure(backgroundColor: UIColor, nextColor: UIColor)
	{
//		contentSize = frame.size
        self.backgroundColor = backgroundColor
		let nextView = UIView(frame: CGRectMake(0, self.contentSize.height, superview?.frame.width ?? 0, 200))
		nextView.backgroundColor = nextColor
//		self.addSubview(nextView)
		self.bounces = true
        addDummyViews(5)
	}
	
    
    func addDummyViews(count: Int){
        for i in 0...count{
            let child = UIView(frame: CGRectMake(dummyViewMargin,dummyViewMargin,frame.size.width - dummyViewMargin*2,dummyViewHeight))
            child.backgroundColor = UIColor.whiteColor()
            self.addSubview(child)
            self.childrenViews.append(child)
            constrain(child, block: { (view1) in
                view1.left == view1.superview!.left + dummyViewMargin
                view1.width == view1.superview!.width - dummyViewMargin * 2
                view1.height == dummyViewHeight
            })
            if i == 0{
                constrain(child)
                {
                    view1 in
                    view1.top == view1.superview!.top + dummyViewMargin
                }
            }else{
                let oldView = self.childrenViews[(i-1)]
                constrain(oldView, child, block: { (view1, view2) in
                    view2.top == view1.bottom + dummyViewMargin
                })
            }
            if i == count{
                constrain(child, block: { (view1) in
                    view1.bottom == view1.superview!.bottom - dummyViewMargin
                })
            }
            child.setNeedsLayout()
            layoutSubviews()
            child.backgroundColor = UIColor.whiteColor()
            child.layer.shadowColor = UIColor.blackColor().CGColor
            child.layer.shadowOpacity = 0.2
            child.layer.shadowOffset = CGSizeMake(0, 2)
            child.layer.cornerRadius = 8
        }
        
        
        
    }
    
}
