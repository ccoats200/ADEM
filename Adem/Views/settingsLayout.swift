//
//  settingsLayout.swift
//  Adem
//
//  Created by Coleman Coats on 2/25/19.
//  Copyright © 2019 Coleman Coats. All rights reserved.
//

import Foundation
import UIKit


class settingsCell: CellBasics {
	
	let profileSection: UIImageView = {
		let profilepic = UIImageView()
		profilepic.image = UIImage(named: "addButton")
		profilepic.contentMode = .center
		//addItemButtonImage.contentMode = .scaleAspectFit
		profilepic.clipsToBounds = true
		profilepic.layer.masksToBounds = true
		print("Created the add button")
		
		return profilepic
	}()
	
	override func setupViews() {
		addSubview(profileSection)
		
		
		addConstraintsWithFormats(format: "H:|[v0]|", views: profileSection)
		addConstraintsWithFormats(format: "V:|[v0]|", views: profileSection)
		
		//		//Top Constraints Quantity
		//		addConstraint(NSLayoutConstraint(item: kitchenStaff, attribute: .top, relatedBy: .equal, toItem: profileSection, attribute: .top, multiplier: 1, constant: 5))
		//		//Right Constraints Quantity
		//		addConstraint(NSLayoutConstraint(item: kitchenStaff, attribute: .right, relatedBy: .equal, toItem: profileSection, attribute: .right, multiplier: 1, constant: -5))
		//		//Height Constraint Quantity
		//		addConstraint(NSLayoutConstraint(item: kitchenStaff, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0, constant: 15))
		//		//Width Constraint
		//		addConstraint(NSLayoutConstraint(item: kitchenStaff, attribute: .height, relatedBy: .equal, toItem: self, attribute: .width, multiplier: 0, constant: 15))
	}
	
	
	
}

