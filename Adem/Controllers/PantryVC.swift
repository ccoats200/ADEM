//
//  PantryVC.swift
//  Adem
//
//  Created by Coleman Coats on 2/25/19.
//  Copyright © 2019 Coleman Coats. All rights reserved.
//

import UIKit
import Foundation
import UIKit
import Firebase
import FirebaseFirestore
import AVFoundation


class PantryVC: UICollectionViewController, UICollectionViewDelegateFlowLayout, UISearchBarDelegate {
	
	var products: [itemCellContent]? = {
		var add = itemCellContent()
		//add.itemImageName = "addButton"
		
		
		var eggs = itemCellContent()
		eggs.itemName = "PantryVC"
		eggs.itemImageName = "bread"
		eggs.Quantity = "1"
		
		var Toast = itemCellContent()
		Toast.itemName = "Bread"
		Toast.itemImageName = "bread"
		Toast.Quantity = "5"
		
		var test = itemCellContent()
		test.itemName = "Strawberries"
		test.itemImageName = "eggs"
		test.Quantity = "2"
		
		return [eggs, Toast, test]
	}()
	
	//reuse ID's
	let cellID = "product"
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		
		//fetchItems()
		
		navigationItem.title = "Pantry"
		
		//Left aligned title
		//let titleTest = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width - 32, height: view.frame.height))
		
		let titleText = UILabel()
		//titleText.text = "Pantry"
		titleText.font = UIFont(name: "Lato", size: 20)
		//titleText.textColor = UIColor.rgb(red: 30, green: 188, blue: 29)
		titleText.textColor = UIColor.rgb(red: 241, green: 249, blue: 255)
		navigationItem.titleView = titleText
		navigationController?.navigationBar.isTranslucent = false
		navigationController?.navigationBar.prefersLargeTitles = true
		//navigationController?.navigationBar.color
		
		collectionView.isScrollEnabled = true
		
		collectionView?.backgroundColor = UIColor.rgb(red: 241, green: 249, blue: 255)
		
		//blue
		//collectionView?.backgroundColor = UIColor.rgb(red: 38, green: 96, blue: 164)
		//green
		//collectionView?.backgroundColor = UIColor.rgb(red: 30, green: 188, blue: 28)
		
		collectionView?.register(pantryCellLayout.self, forCellWithReuseIdentifier: cellID)
		
		//This moves the Cells to the correct offsets, Stylistic choice
		collectionView?.contentInset = UIEdgeInsets.init(top: 1, left: 1, bottom: 1, right: 1)
		
		collectionView?.scrollIndicatorInsets = UIEdgeInsets.init(top: 0, left: 0, bottom: 50, right: 0)
		
		setUpTabBar()
		setUpNavBarButton()
		
		//Search
		self.collectionView.contentOffset = CGPoint(x: 0.0, y: 11.0)
		
		searchBar.delegate = self
		
		
		let Columns: CGFloat = 3.0
		let insetDimension: CGFloat = 2.0
		let cellHeight: CGFloat = 125.0
		let cellWidth = (collectionView.frame.width/Columns) - insetDimension
		let layouts = collectionViewLayout as! UICollectionViewFlowLayout
		layouts.itemSize = CGSize(width: cellWidth, height: cellHeight)
		
		
	}
	
	//SearchBar
	lazy var searchBar: UISearchBar = {
		let bar = UISearchBar()
		bar.translatesAutoresizingMaskIntoConstraints = false
		bar.barTintColor = UIColor.rgb(red: 241, green: 249, blue: 255)
		bar.backgroundColor = UIColor.rgb(red: 241, green: 249, blue: 255)
		//mask shadow
		bar.layer.borderColor = UIColor.rgb(red: 241, green: 249, blue: 255).cgColor
		bar.layer.borderWidth = 1
		
		return bar
	}()
	
	
	
	func setup() {
		let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(down))
		swipeDown.direction = .down
		
		let swipeUp = UISwipeGestureRecognizer(target: self, action: #selector(up))
		swipeUp.direction = .up
		
		self.view.addGestureRecognizer(swipeDown)
		self.view.addGestureRecognizer(swipeUp)
		
		/*
		searchBar = UISearchBar(frame: CGRect(x: 0.0, y: 0.0, width: self.view.frame.size.width, height: 40.0))
		if let searchBar = searchBar
		{
		searchBar.backgroundColor = UIColor.red
		self.view.addSubview(searchBar)
		}
		*/
	}
	
	//Swipe Down to search
	@objc func down(sender: UIGestureRecognizer) {
		print("down")
		//show bar
		UIView.animate(withDuration: 1.0, animations: { () -> Void in
			self.searchBar.frame = CGRect(x: 0.0, y: 64.0, width: self.view.frame.width, height: 40.0)
		}, completion: { (Bool) -> Void in
		})
	}
	
	@objc func up(sender: UIGestureRecognizer) {
		print("up")
		UIView.animate(withDuration: 1.0, animations: { () -> Void in
			self.searchBar.frame = CGRect(x: 0.0, y: 0.0, width: self.view.frame.width, height: 40.0)
		}, completion: { (Bool) -> Void in
		})
	}
	
	
	func setUpNavBarButton() {
		
		let accountImage = UIBarButtonItem(image: UIImage(named: "Knife")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(handleAccount))
		
		navigationItem.leftBarButtonItem = accountImage
		
		
	}
	
	
	
	//Account Button
	@objc func handleAccount() {
		
		//This is for the multiple collection views, horizontal and vertical
		let aController = AccountVC()
		
		self.navigationController?.pushViewController(aController, animated: true)
		//self.present(aController, animated: true, completion: nil)
		print("Acccount tab is active")
	}
	
	//product Button
	@objc func handleProduct() {
		
		
		let cController = productVCLayout()
		//let cController = ProductVC(collectionViewLayout: UICollectionViewFlowLayout())
		cController.hidesBottomBarWhenPushed = true
		self.navigationController?.pushViewController(cController, animated: true)
		
		
		print("Settings Tab is active")
	}
	
	
	
	private func setUpTabBar() {
		//view.addSubview(tabBar)
		view.addSubview(searchBar)
		
		searchBar.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
		searchBar.widthAnchor.constraint(equalToConstant: view.frame.width).isActive = true
		searchBar.heightAnchor.constraint(equalToConstant: 10).isActive = true
		//searchBar.setPositionAdjustment(UIOffset, for: UISearchBar.Icon)
		
		//view.addConstraintsWithFormats(format: "H:|[v0]|", views: tabBar)
		//view.addConstraintsWithFormats(format: "V:[v0(70)]|", views: tabBar)
		
		
	}
	
	//Number of cells. update later for collection of cells based on product type
	override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		
		return products!.count
	}
	
	//Initiating cell
	override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		
		let productCell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! pantryCellLayout
		productCell.backgroundColor = UIColor.rgb(red: 252, green: 252, blue: 252) //off white blue color
		//productCell.layer.cornerRadius = 5
		print("Rounds corners")
		
		productCell.gItem = products![indexPath.item]
		
		//collectionview.insertIems(at: indexPaths)
		
		//Shadow
		productCell.layer.shadowColor = UIColor.gray.cgColor
		productCell.layer.shadowOffset = CGSize(width: 0, height: 3.0)
		productCell.layer.shadowOpacity = 0.7
		productCell.layer.shadowRadius = 2.0
		productCell.layer.masksToBounds = false
		productCell.layer.shadowPath = UIBezierPath(roundedRect: productCell.bounds, cornerRadius: productCell.contentView.layer.cornerRadius).cgPath;
		return productCell
	}
	
	
	//Lets Build that app ep.16
	//	override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
	//		let Prod = productViewC()
	//		Prod.showProduct()
	//	}
	
	override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		
		handleProduct()
		print("123")
	}
	
	
	/*
	//Size of Cell
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
	let Columns: CGFloat = 3.0
	//let height = ((view.frame.width/3.2) - 2 - 2) * 9 / 16
	//height + 2 + 129
	print("Sets the hight of the cell")
	
	
	
	
	
	//let cellWidth = collectionView.bounds.width/3.6
	//let cellHeight: CGFloat = 125
	
	
	//let widths = self.view.frame.width
	//view.frame.width / 3.6
	
	//let sizeofCell = CGSize(width: cellWidth, height: cellHeight) //25 points go to the product info (150)
	return sizeofCell
	}
	*/
	
	//Space between rows
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
		return 25
	}
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
		return 0
	}
}
