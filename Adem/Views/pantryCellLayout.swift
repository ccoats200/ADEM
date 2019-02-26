//
//  pantryCellLayout.swift
//  Adem
//
//  Created by Coleman Coats on 2/25/19.
//  Copyright © 2019 Coleman Coats. All rights reserved.
//

import UIKit
import Firebase
import FirebaseFirestore


//Pantry Product Cell layout
class pantryCellLayout: CellBasics {
	
	var gItem: itemCellContent? {
		didSet {
			productImageView.image = UIImage(named: (gItem?.itemImageName)!)
			productName.text = gItem?.itemName
			quantity.text = gItem?.Quantity
			
			print("set")
		}
	}
	
	let productImageView: UIImageView = {
		let image = UIImageView()
		//image.image = UIImage(named: itemImageName)
		image.contentMode = .scaleAspectFill
		image.clipsToBounds = true
		//image.layer.cornerRadius = 5
		image.layer.masksToBounds = true
		print("rounds the corners of the image view")
		return image
	}()
	
	let productName: UILabel = {
		let name = UILabel()
		//name.text = "\(itemName)"
		name.textAlignment = .center
		name.numberOfLines = 1
		name.adjustsFontSizeToFitWidth = true
		print("sets the item name")
		return name
	}()
	
	let quantity: UILabel = {
		let Quant = UILabel()
		//Quant.text = "\(Quantity)"
		print("sets the quantity of the items in the cart")
		Quant.font = UIFont(name: "Helvetica", size: 12)
		Quant.textColor = UIColor.rgb(red: 57, green: 94, blue: 102)
		Quant.translatesAutoresizingMaskIntoConstraints = false
		//Quant.backgroundColor = UIColor.green
		return Quant
	}()
	
	//SearchBar
	lazy var searchBar: UISearchBar = {
		let bar = UISearchBar()
		bar.translatesAutoresizingMaskIntoConstraints = false
		//bar.backgroundColor = UIColor.blue
		return bar
	}()
	
	override func setupViews() {
		addSubview(productImageView)
		print("adds the product image subview")
		addSubview(productName)
		print("adds the product name subview")
		addSubview(quantity)
		print("adds the calorie count subview")
		
		addSubview(searchBar)
		//Horizontral Constaints
		addConstraintsWithFormats(format: "H:|-2-[v0]-2-|", views: productImageView)
		addConstraintsWithFormats(format: "H:|-8-[v0]-8-|", views: productName)
		//addConstraintsWithFormats(format: "H:|-3-[v0]-3-[v1(50)]-8-[v2(40)]", views: productName, price, Quantity)
		
		//Vertical Constraints (productImageView = 105)
		addConstraintsWithFormats(format: "V:|-2-[v0(100)]-1-[v1(20)]-3-|", views: productImageView, productName)
		//addConstraintsWithFormats(format: "V:|-3-[v0(105)]-4-[v1(20)]-8-[v2(1)]|", views: productImageView, productName, seperatorView)
		
		
		//Constraints: Only use if multiple constraints needed on same view
		
		//Top Constraints Quantity
		addConstraint(NSLayoutConstraint(item: quantity, attribute: .top, relatedBy: .equal, toItem: productImageView, attribute: .top, multiplier: 1, constant: 5))
		//Right Constraints Quantity
		addConstraint(NSLayoutConstraint(item: quantity, attribute: .right, relatedBy: .equal, toItem: productImageView, attribute: .right, multiplier: 1, constant: -5))
		//Height Constraint Quantity
		addConstraint(NSLayoutConstraint(item: quantity, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0, constant: 15))
		//Width Constraint
		addConstraint(NSLayoutConstraint(item: quantity, attribute: .height, relatedBy: .equal, toItem: self, attribute: .width, multiplier: 0, constant: 15))
		
	}
}
