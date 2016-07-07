//
//  BaseScrollView.swift
//  swipeyScrolley
//
//  Created by Vmock on 07/07/16.
//  Copyright © 2016 comicsans. All rights reserved.
//

import UIKit
import Cartography
class BaseScrollView: UIScrollView, UITableViewDelegate, UITableViewDataSource {
	
	/*
	// Only override drawRect: if you perform custom drawing.
	// An empty implementation adversely affects performance during animation.
	override func drawRect(rect: CGRect) {
	// Drawing code
	}
	*/
    let tableView = UITableView(frame: CGRectMake(0, 0, 300, 100))
    let dummyViewMargin:CGFloat = 20.0
    let dummyViewHeight:CGFloat = 256
    var childrenViews:[UIView] = []
    let dataValues = Array(1...6)
	func configure(backgroundColor: UIColor, nextColor: UIColor)
	{
//		contentSize = frame.size
        self.backgroundColor = backgroundColor
		let nextView = UIView(frame: CGRectMake(0, self.contentSize.height, superview?.frame.width ?? 0, 200))
		nextView.backgroundColor = nextColor
//		self.addSubview(nextView)
		self.bounces = true
        addDummyViews(5)
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.dataSource = self
        tableView.dataSource = self
        self.addSubview(tableView)
        addTableView()
	}
	
    func addTableView(){
        tableView.contentSize = tableView.sizeThatFits(CGSizeMake(tableView.contentSize.width, CGFloat.max))
        let tableViewHeight = tableView.contentSize.height
        constrain(tableView, childrenViews.last!) { (tableView, lastChild) in
            tableView.top == lastChild.bottom + dummyViewMargin
            tableView.left == tableView.superview!.left + dummyViewMargin
            tableView.width == tableView.superview!.width - dummyViewMargin * 2
            tableView.height == tableViewHeight
            tableView.bottom == tableView.superview!.bottom - dummyViewMargin * 2
        }
        layoutSubviews()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataValues.count
    }
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath)
        cell.textLabel?.text = String(dataValues[indexPath.row])
        return cell
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
//            if i == count{
//                constrain(child, block: { (view1) in
//                    view1.bottom == view1.superview!.bottom - dummyViewMargin
//                })
//            }
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
