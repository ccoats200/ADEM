//
//  CellLayout.swift
//  Adem
//
//  Created by Coleman Coats on 2/25/19.
//  Copyright © 2019 Coleman Coats. All rights reserved.
//

import UIKit
import Firebase
import FirebaseFirestore

//ADD new product Cell
class addProductCell: CellBasics {
	
	let addItem: UIImageView = {
		let addItemButtonImage = UIImageView()
		addItemButtonImage.image = UIImage(named: "addButton")
		addItemButtonImage.contentMode = .center
		//addItemButtonImage.contentMode = .scaleAspectFit
		addItemButtonImage.clipsToBounds = true
		addItemButtonImage.layer.masksToBounds = true
		print("Created the add button")
		
		
		return addItemButtonImage
	}()
	
	override func setupViews() {
		addSubview(addItem)
		setUpAddButton()
		
		addConstraintsWithFormats(format: "H:|[v0]|", views: addItem)
		addConstraintsWithFormats(format: "V:|[v0]|", views: addItem)
	}
	
	func setUpAddButton(){
		print(123)
	}
	
	@objc func handleAdd() {
		print(123)
	}
}

//HomePage Product Cell layout
class productCellLayout: CellBasics {
	
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
		image.layer.cornerRadius = 5
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

//Profile Image Product Cell layout
class profileImageCellLayout: CellBasics {
	
	var docRef: DocumentReference!
	var handle: AuthStateDidChangeListenerHandle?
	let user = Auth.auth().currentUser
	let minimuPasswordCount = 6
	
	
	
	var profileImage: profileContent? {
		didSet {
			
			userProfileImageView.image = UIImage(named: (profileImage?.profileImage)!)
			userProfileName.text = profileImage?.personName
			
			print("set")
		}
	}
	//
	//	var profileImage: profileContent? {
	//		didSet {
	//			userProfileImageView.image = UIImage(named: (profileImage?.profileImage)!)
	//			docRef.addSnapshotListener { (docSnapshot, error) in
	//				guard let docSnapshot = docSnapshot, docSnapshot.exists else { return }
	//				let userNameData = docSnapshot.data()
	//				let usersName = userNameData?["FirstName"] as? String ?? ""
	//				self.userProfileName.text = "test"//"\"\(usersName)\""
	//			}
	//
	//			//userProfileImageView.image = UIImage(named: (profileImage?.profileImage)!)
	//			//userProfileName.text = profileImage?.personName
	//
	//			print("set")
	//		}
	//	}
	
	
	
	let userProfileImageView: UIImageView = {
		let userImage = UIImageView()
		//image.image = UIImage(named: itemImageName)
		userImage.contentMode = .scaleAspectFill
		userImage.clipsToBounds = true
		userImage.layer.cornerRadius = 50
		userImage.layer.masksToBounds = true
		print("rounds the corners of the image view")
		userImage.layer.borderWidth = 2
		userImage.layer.borderColor = UIColor.white.cgColor
		
		return userImage
	}()
	
	
	let userProfileName: UILabel = {
		let userName = UILabel()
		userName.textAlignment = .center
		userName.numberOfLines = 1
		userName.adjustsFontSizeToFitWidth = true
		
		userName.font = UIFont.boldSystemFont(ofSize: 20)
		print("sets the item name")
		return userName
	}()
	
	
	
	
	override func setupViews() {
		addSubview(userProfileImageView)
		print("adds the product image subview")
		addSubview(userProfileName)
		print("adds the product name subview")
		
		
		//Horizontral Constaints
		addConstraintsWithFormats(format: "H:|-45-[v0(100)]-45-|", views: userProfileImageView)
		addConstraintsWithFormats(format: "H:|-8-[v0]-8-|", views: userProfileName)
		
		
		
		
		//Vertical Constraints (productImageView = 105)
		addConstraintsWithFormats(format: "V:|-5-[v0(100)]-5-[v1(20)]|", views: userProfileImageView, userProfileName)
		
		
	}
}

//Profile Image Product Cell layout
class friendsCellLayout: CellBasics {
	
	var docRef: DocumentReference!
	var handle: AuthStateDidChangeListenerHandle?
	let user = Auth.auth().currentUser
	let minimuPasswordCount = 6
	
	
	
	var profileImage: profileContent? {
		didSet {
			
			userProfileImageView.image = UIImage(named: (profileImage?.profileImage)!)
			userProfileName.text = profileImage?.personName
			
			print("set")
		}
	}
	//
	//	var profileImage: profileContent? {
	//		didSet {
	//			userProfileImageView.image = UIImage(named: (profileImage?.profileImage)!)
	//			docRef.addSnapshotListener { (docSnapshot, error) in
	//				guard let docSnapshot = docSnapshot, docSnapshot.exists else { return }
	//				let userNameData = docSnapshot.data()
	//				let usersName = userNameData?["FirstName"] as? String ?? ""
	//				self.userProfileName.text = "test"//"\"\(usersName)\""
	//			}
	//
	//			//userProfileImageView.image = UIImage(named: (profileImage?.profileImage)!)
	//			//userProfileName.text = profileImage?.personName
	//
	//			print("set")
	//		}
	//	}
	
	
	
	let userProfileImageView: UIImageView = {
		let userImage = UIImageView()
		//image.image = UIImage(named: itemImageName)
		userImage.contentMode = .scaleAspectFill
		userImage.clipsToBounds = true
		userImage.layer.cornerRadius = 50
		userImage.layer.masksToBounds = true
		print("rounds the corners of the image view")
		userImage.layer.borderWidth = 2
		userImage.layer.borderColor = UIColor.white.cgColor
		
		return userImage
	}()
	
	
	let userProfileName: UILabel = {
		let userName = UILabel()
		userName.textAlignment = .center
		userName.numberOfLines = 1
		userName.adjustsFontSizeToFitWidth = true
		
		userName.font = UIFont.boldSystemFont(ofSize: 20)
		print("sets the item name")
		return userName
	}()
	
	
	
	
	override func setupViews() {
		addSubview(userProfileImageView)
		print("adds the product image subview")
		addSubview(userProfileName)
		print("adds the product name subview")
		
		
		//Horizontral Constaints
		addConstraintsWithFormats(format: "H:|[v0]|", views: userProfileImageView)
		addConstraintsWithFormats(format: "H:|-8-[v0]-8-|", views: userProfileName)
		
		
		
		
		//Vertical Constraints (productImageView = 105)
		addConstraintsWithFormats(format: "V:|-5-[v0]-5-[v1]|", views: userProfileImageView, userProfileName)
		
		
	}
}

//Account and Privacy Image Product Cell layout
class accountPrivacyCellDesign: CellBasics {
	
	var accountImage: accountPrivacy? {
		didSet {
			accountPrivacyImages.image = UIImage(named: (accountImage?.accountImage)!)
			accountPrivacyLabels.text = accountImage?.userNameLabel
			
			print("The Account and Privacy celll layout and UI elements are set")
		}
	}
	
	let accountPrivacyImages: UIImageView = {
		let aPImages = UIImageView()
		aPImages.image = UIImage(named: "Gear")
		aPImages.contentMode = .scaleAspectFit
		aPImages.clipsToBounds = true
		aPImages.layer.masksToBounds = true
		print("rounds the corners of the image view")
		
		aPImages.translatesAutoresizingMaskIntoConstraints = false
		//aPImages.backgroundColor = UIColor.rgb(red: 241, green: 249, blue: 255)
		
		return aPImages
	}()
	
	let accountPrivacyLabels: UILabel = {
		let aPLabels = UILabel()
		aPLabels.textAlignment = .center
		aPLabels.text = "Settings"
		aPLabels.textColor
			= UIColor.white
		aPLabels.numberOfLines = 1
		aPLabels.adjustsFontSizeToFitWidth = true
		//aPLabels.backgroundColor = UIColor.red
		aPLabels.font = UIFont.boldSystemFont(ofSize: 20)
		aPLabels.translatesAutoresizingMaskIntoConstraints = false
		print("sets the item name")
		return aPLabels
	}()
	
	
	
	
	override func setupViews() {
		addSubview(accountPrivacyImages)
		print("adds the product image subview")
		addSubview(accountPrivacyLabels)
		print("adds the product name subview")
		
		
		accountPrivacyImages.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
		accountPrivacyImages.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
		
		accountPrivacyLabels.heightAnchor.constraint(equalToConstant: 20).isActive = true
		accountPrivacyLabels.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
		accountPrivacyLabels.topAnchor.constraint(equalTo: accountPrivacyImages.bottomAnchor, constant: 10).isActive = true
		accountPrivacyLabels.widthAnchor.constraint(equalTo: self.widthAnchor, constant: -50).isActive = true
	
		
		
	}
}


