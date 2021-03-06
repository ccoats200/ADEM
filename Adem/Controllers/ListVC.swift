//
//  ListVC.swift
//  Adem
//
//  Created by Coleman Coats on 2/25/19.
//  Copyright © 2019 Coleman Coats. All rights reserved.
//

import Foundation
import UIKit
import Firebase
import FirebaseFirestore
import AVFoundation


class CustomCollecCellDesign: UICollectionViewController, UICollectionViewDelegateFlowLayout, UISearchBarDelegate {
	
	let productRFIDNumber = "3860407808"
	
	
	
	//reuse ID's
	let cellID = "product"
	
	var products: [itemCellContent]? = {
		var add = itemCellContent()
		
		
		var eggs = itemCellContent()
		eggs.itemName = "Egg"
		eggs.itemImageName = "eggs"
		eggs.Quantity = "1"
		
		var Toast = itemCellContent()
		Toast.itemName = "Bread"
		Toast.itemImageName = "bread"
		Toast.Quantity = "5"
		
		var test = itemCellContent()
		test.itemName = "Strawberries"
		test.itemImageName = "blueBerry"
		test.Quantity = "10"
		
		
		return [eggs, Toast, test]
	}()
	
	
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		
		self.collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
		
		
		let titleText = UILabel()
		titleText.text = "List"
		titleText.font = UIFont(name: "Lato", size: 20)
		//titleText.textColor = UIColor.rgb(red: 30, green: 188, blue: 29)
		titleText.textColor = UIColor.rgb(red: 241, green: 249, blue: 255)
		navigationItem.titleView = titleText
		navigationController?.navigationBar.isTranslucent = false
		
		
		collectionView.isScrollEnabled = true
		
		
		
		collectionView?.backgroundColor = UIColor.rgb(red: 241, green: 249, blue: 255)
		
		
		
		collectionView?.register(productCellLayout.self, forCellWithReuseIdentifier: cellID)
		
		//This moves the Cells to the correct offsets, Stylistic choice
		collectionView?.contentInset = UIEdgeInsets.init(top: 20, left: 20, bottom: 20, right: 20)
		
		collectionView?.scrollIndicatorInsets = UIEdgeInsets.init(top: 0, left: 0, bottom: 50, right: 0)
		
		setUpTabBar()
		setUpNavBarButton()
		
		
		//Search
		self.collectionView.contentOffset = CGPoint(x: 0.0, y: 11.0)
		
		searchBar.delegate = self
		
		
		let Columns: CGFloat = 3.0
		let insetDimension: CGFloat = 20.0
		let cellHeight: CGFloat = 125.0
		let cellWidth = (collectionView.frame.width/Columns) - insetDimension
		let layouts = collectionViewLayout as! UICollectionViewFlowLayout
		layouts.itemSize = CGSize(width: cellWidth, height: cellHeight)
		
		
		
		//Swipe Down
		let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(panGestureRecognizerAction(_:)))
		self.view.addGestureRecognizer(panGestureRecognizer)
		
	}
	
	@objc func panGestureRecognizerAction(_ gesture: UIPanGestureRecognizer) {
		
		print(gesture)
		
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
	
	//Keyboard disappears
	func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
		
		searchBar.resignFirstResponder()
		view.endEditing(true)
		
	}
	
	func setupKeyboardDismissRecognizer(){
		let tapRecognizer: UITapGestureRecognizer = UITapGestureRecognizer(
			target: self,
			action: #selector(CustomCollecCellDesign.searchBarSearchButtonClicked))
		
		self.view.addGestureRecognizer(tapRecognizer)
	}
	
	
	
	func setup() {
		let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(down))
		swipeDown.direction = .down
		
		let swipeUp = UISwipeGestureRecognizer(target: self, action: #selector(up))
		swipeUp.direction = .up
		
		self.view.addGestureRecognizer(swipeDown)
		self.view.addGestureRecognizer(swipeUp)
		
		//searchBar = UISearchBar(frame: CGRect(x: 0.0, y: 0.0, width: self.view.frame.size.width, height: 40.0))
		//		if let searchBar = searchBar
		//		{
		//			searchBar.backgroundColor = UIColor.red
		//	self.view.addSubview(searchBar)
		//}
		
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
		
		
		let searchImage = UIBarButtonItem(image: UIImage(named: "search")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(handleSearch))
		
		
		navigationItem.leftBarButtonItem = accountImage
		navigationItem.rightBarButtonItem = searchImage
		
		
	}
	
	//Account Button
	@objc func handleAccount() {
		
		//This is for the multiple collection views, horizontal and vertical
		
		//This is for the collectionView set up
		let accountScreen = AccountVC()
		
		accountScreen.hidesBottomBarWhenPushed = true
		self.navigationController?.pushViewController(accountScreen, animated: true)
		
		
		
		//self.present(aController, animated: true, completion: nil)
		print("Acccount tab is active")
	}
	
	//product Button
	@objc func handleProduct() {
		
		//transition testing
		//let transitionCoordinator = TransitionCoordinator()
		
		let cController = productVCLayout()
		cController.hidesBottomBarWhenPushed = true
		
		//transition testing
		//cController.transitioningDelegate = transitionCoordinator as? UIViewControllerTransitioningDelegate
		
		
		//self.navigationController?.pushViewController(cController, animated: true)
		self.present(cController, animated: true, completion: nil)
		//self.dismiss(animated: true, completion: nil)
		
		print("Settings Tab is active")
	}
	
	//Search Button
	@objc func handleSearch() {
		//let cController = SettingsVC()
		let cController = login()
		self.navigationController?.pushViewController(cController, animated: true)
		print("Settings Tab is active")
	}
	
	
	
	
	
	private func setUpTabBar() {
		//view.addSubview(tabBar)
		view.addSubview(searchBar)
		
		searchBar.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
		searchBar.widthAnchor.constraint(equalToConstant: view.frame.width).isActive = true
		searchBar.heightAnchor.constraint(equalToConstant: 50).isActive = true
		//searchBar.setPositionAdjustment(UIOffset, for: UISearchBar.Icon)
		
		
		
	}
	
	
	//Number of cells. update later for collection of cells based on product type
	override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		
		//incremental increase
		/*
		for groceryProducts in cloudStorage {
			if groceryProducts //increases
			{
				products.append to list
			}
		}
		*/
		
		return products!.count
	}
	
	//Initiating cell
	override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		
		let productCell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! productCellLayout
		productCell.backgroundColor = UIColor.rgb(red: 252, green: 252, blue: 252) //off white blue color
		productCell.layer.cornerRadius = 5
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
	
	

	
	override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		
		if indexPath.item == 1 {
			handleProduct()
		} else {
			handleAlert()
		}
		
		print("123")
	}
	
	/*
	var alertInfo: [thrownOut]? = {
		var add = thrownOut()
		
		
		return [add]
		
	}()

*/
	
	//Search Button
	@objc func handleAlert() {
		
	
		//var products: [itemCellContent]?
		
		let alert = addedItemAlert()
		//alert.alertAssets?.alertProductName = itemCellContent().itemName
		//alert.alertAssets?.alertProductImageName = itemCellContent().itemImageName
		alert.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
		
		self.present(alert, animated: true, completion: nil)
		
	}
	
	
	//Space between rows
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
		return 25
	}
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
		return 0
	}
}
