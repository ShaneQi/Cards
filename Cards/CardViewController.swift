//
//  CardViewController.swift
//  Cards
//
//  Created by Shane Qi on 7/19/16.
//  Copyright © 2016 com.github.shaneqi. All rights reserved.
//

import UIKit

class CardViewController: UIViewController {

	@IBOutlet var cardTableView: UITableView!
	
	var focusedCard = 4
	
	let redPrimary = UIColor(red: 244/255, green: 67/255, blue: 54/255, alpha: 1)		// D32F2F
	let indigoPrimary = UIColor(red: 63/255, green: 81/255, blue: 181/255, alpha: 1)	// 3F51B5
	let greenPrimary = UIColor(red: 76/255, green: 175/255, blue: 80/255, alpha: 1)		// 4CAF50
	let orangePrimary = UIColor(red: 255/255, green: 152/255, blue: 0/255, alpha: 1)	// FF9800
	let purplePrimary = UIColor(red: 156/255, green: 39/255, blue: 176/255, alpha: 1)	// 9C27B0
	var colors: [UIColor] {
		return [redPrimary, indigoPrimary, greenPrimary, orangePrimary, purplePrimary]
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		cardTableView.registerNib(UINib(nibName: CardCell.nibName, bundle: nil), forCellReuseIdentifier: CardCell.identifier)
	}

}

extension CardViewController: UITableViewDataSource {
	
	func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return 5
	}
	
	func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCellWithIdentifier(CardCell.identifier)! as! CardCell
		if focusedCard == indexPath.row { cell.zoom(.In) }
		cell.cardContent.backgroundColor = colors[indexPath.row]
		return cell
	}
	
}

extension CardViewController: UITableViewDelegate {
	
	func tableView(tableView: UITableView, willSelectRowAtIndexPath indexPath: NSIndexPath) -> NSIndexPath? {
		(tableView.cellForRowAtIndexPath(NSIndexPath(forRow: focusedCard, inSection: 0)) as! CardCell).zoom(.Out)
		focusedCard = indexPath.row
		(tableView.cellForRowAtIndexPath(NSIndexPath(forRow: focusedCard, inSection: 0)) as! CardCell).zoom(.In)
		tableView.beginUpdates()
		tableView.endUpdates()
		tableView.visibleCells.forEach({ $0.superview?.bringSubviewToFront($0) })
		return nil
	}
	
	func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
		if indexPath.row == focusedCard { return 205 }
		else { return tableView.rowHeight }
	}
	
	func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
		if indexPath == tableView.indexPathsForVisibleRows?.last {
			(tableView.visibleCells + [cell]).forEach({ $0.superview?.bringSubviewToFront($0) })
		}
	}
	
}