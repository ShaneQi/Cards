//
//  CardCell.swift
//  Cards
//
//  Created by Shane Qi on 7/19/16.
//  Copyright © 2016 com.github.shaneqi. All rights reserved.
//

import UIKit

class CardCell: UITableViewCell {

	static let identifier = "CardCell"
	
	@IBOutlet var cardContent: UIView!
	@IBOutlet var cardContentWidth: NSLayoutConstraint!
	
	override func awakeFromNib() {
		cardContent.layer.cornerRadius = 5
		self.backgroundColor = UIColor.clearColor()
		self.clipsToBounds = false
		let clearView = UIView()
		clearView.backgroundColor = UIColor.clearColor()
		self.selectedBackgroundView? = clearView
		self.layer.masksToBounds = false
		self.layer.shadowOffset = CGSizeMake(0, -1)
		self.layer.shadowRadius = 5
		self.layer.shadowOpacity = 0.5
	}
	
	func zoom(mode: Zoom) {
		switch mode {
		case .In:
			cardContentWidth.constant = -16
		case .Out:
			cardContentWidth.constant = -32
		}
		UIView.animateWithDuration(0.5, animations: {
			self.layoutIfNeeded()
		})
	}
	
	enum Zoom {
		case In, Out
	}
	
}
