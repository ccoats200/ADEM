//
//  AccountVC.swift
//  Adem
//
//  Created by Coleman Coats on 2/25/19.
//  Copyright © 2019 Coleman Coats. All rights reserved.
//

import Foundation
import UIKit
import CoreBluetooth
import Firebase
import FirebaseFirestore

//Decoration View for section background color
//class SCSBCollectionViewLayoutAttributes : UICollectionViewLayoutAttributes {
//
//	var color: UIColor = UIColor.white
//
//	override func copyWithZone(zone: NSZone) -> AnyObject {
//		let newAttributes: SCSBCollectionViewLayoutAttributes = super.copyWithZone(zone) as! SCSBCollectionViewLayoutAttributes
//		newAttributes.color = self.color.copyWithZone(zone) as! UIColor
//		return newAttributes
//	}
//}
//
//class SCSBCollectionReusableView : UICollectionReusableView {
//	override func apply(_ layoutAttributes: UICollectionViewLayoutAttributes) {
//		super.apply(layoutAttributes)
//		let scLayoutAttributes = layoutAttributes as! SCSBCollectionViewLayoutAttributes
//		self.backgroundColor = scLayoutAttributes.color
//	}
//}


class AccountVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
	
	var docRef: DocumentReference!
	var handle: AuthStateDidChangeListenerHandle?
	let user = Auth.auth().currentUser
	
	
	//Cell Id's
	let cellId = "cellId0"
	let cellId2 = "cell1"
	let cellId3 = "cell2"
	let cellId4 = "cell3"
	
	
	var db: Firestore!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		let settings = FirestoreSettings()
		
		Firestore.firestore().settings = settings
		// [END setup]
		db = Firestore.firestore()
		
		docRef = Firestore.firestore().document("UserLoginInfo/user")
		
		collectionView.isScrollEnabled = false
		collectionView.backgroundColor = UIColor.rgb(red: 30, green: 188, blue: 29)
		//self.tabBarController?.tabBar.isHidden = true
		
		let titleText = UILabel()
		titleText.text = "Profiles"
		titleText.font = UIFont(name: "Lato", size: 40)
		titleText.font = UIFont.boldSystemFont(ofSize: 20)
		titleText.textColor = UIColor.white
		navigationItem.titleView = titleText
		
		//setUpNavBarButton()
		
		//Image cell
		collectionView.register(profileImageCellLayout.self, forCellWithReuseIdentifier: cellId)
		
		
		//Family Cell
		//Collection view scrollable
		//collectionView.register(familySection.self, forCellWithReuseIdentifier: cellId2)
		collectionView.register(friendsCellLayout.self, forCellWithReuseIdentifier: cellId2)
		
		//collectionView.register(familyCells.self, forCellWithReuseIdentifier: cellId2)
		
		//Device Cell
		collectionView.register(deviceSection.self, forCellWithReuseIdentifier: cellId3)
		//Please work
		
		
		//Allergies Cell
		collectionView.register(accountPrivacyCellDesign.self, forCellWithReuseIdentifier: cellId4)
		
		self.collectionView.register(friendsCellLayout.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: self.headerID)
		
		//let flow = self.collectionView.collectionViewLayout as! UICollectionViewFlowLayout
		//flow.headerReferenceSize = CGSize(30,30)
		
		setupViews() //setup all views
		
		
	}
	let headerID = "test"
	
	/*
	override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
	var v : UICollectionReusableView! = nil
	if kind == UICollectionView.elementKindSectionHeader {
	v = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: self.headerID, for: indexPath)
	if v.subviews.count == 0 {
	v.addSubview(UILabel(frame:CGRect(0,0,30,30)))
	}
	let lab = v.subviews[0] as! UILabel
	lab.text = self.sections[indexPath.section].sectionName
	lab.textAlignment = .center
	}
	return v
	}
	
	
	*/
	
	/*
	func setUpNavBarButton() {
		
		
		let searchImage = UIBarButtonItem(image: UIImage(named: "search")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(handleSearch))
		navigationItem.rightBarButtonItem = searchImage
	}
	*/
	
	//Search Button
	@objc func handleSearch() {
		//let cController = SettingsVC()
		let cController = SettingTVC()
		self.navigationController?.pushViewController(cController, animated: true)
		print("Settings Tab is active")
	}
	
	//Privacy Button
	@objc func handlePrivacy() {
		
		let privacyController = privacyTVC()
		self.navigationController?.pushViewController(privacyController, animated: true)
		print("Settings Tab is active")
	}
	
	
	let sView: UIView = {
		let seperate = UIView()
		seperate.backgroundColor = UIColor.rgb(red: 230, green: 230, blue: 230)
		print("sets the seperator color")
		return seperate
		
	}()
	
	func setupViews() {
		
		//view.addSubview(AccountView)
		view.addSubview(collectionView) // add collection view to view controller
		
		collectionView.delegate = self // set delegate
		collectionView.dataSource = self //set data source
		
		
		//AccountView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
		//AccountView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
		//AccountView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
		//AccountView.heightAnchor.constraint(equalTo: view.widthAnchor).isActive = true
		
		collectionView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true //set the location of collection view
		collectionView.rightAnchor.constraint(equalTo:  view.rightAnchor).isActive = true // top anchor of collection view
		collectionView.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true // height
		collectionView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true // width
		
	}
	
	let AccountView: UIView = {
		let av = UIView()
		av.translatesAutoresizingMaskIntoConstraints = false
		
		return av
		
	}()
	
	let collectionView: UICollectionView = { // collection view to be added to view controller
		let cv = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout());//zero size with flow layout
		cv.translatesAutoresizingMaskIntoConstraints = false; //set it to false so that we can suppy constraints
		cv.backgroundColor = .white // test
		return cv
		
	}()
	
	//profile
	//	var profile: [profileContent]? = {
	//		var userImage = profileContent()
	//		userImage.personName = "Colemans"
	//		userImage.profileImage = "eggs"
	//		return [userImage]
	//	}()
	//
	
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		
		docRef.addSnapshotListener { (docSnapshot, error) in
			guard let docSnapshot = docSnapshot, docSnapshot.exists else { return }
			let userNameData = docSnapshot.data()
			let usersName = userNameData?["FirstName"] as? String ?? ""
			profileImageCellLayout().userProfileName.text = "\(usersName)"
			profileImageCellLayout().userProfileImageView.image = UIImage(named: "eggs")
		}
		
	}
	
	var acct: [accountPrivacy]? = {
		
		var acctImage = accountPrivacy()
		acctImage.accountImage = "Coleman"
		acctImage.userNameLabel = "eggs"
		
		var privacyImage = accountPrivacy()
		privacyImage.accountImage = "Coleman"
		privacyImage.userNameLabel = "eggs"
		
		return [acctImage, privacyImage]
	}()
	
	
	//deque cell
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		
		switch indexPath.section {
		case 0:
			
			let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! profileImageCellLayout
			//cell.profileImage = profile![indexPath.item]
			
			
			return cell
			
		case 1:
			let cell2 = collectionView.dequeueReusableCell(withReuseIdentifier: cellId2, for: indexPath) as! friendsCellLayout
			cell2.backgroundColor = UIColor.blue
			cell2.layer.cornerRadius = 5
			return cell2
			
		case 2:
			let cell3 = collectionView.dequeueReusableCell(withReuseIdentifier: cellId3, for: indexPath)
			return cell3
			
		case 3:
			if indexPath.item == 0 {
				let accountInfo = collectionView.dequeueReusableCell(withReuseIdentifier: cellId4, for: indexPath) as! accountPrivacyCellDesign
				
				accountInfo.layer.borderWidth = 2
				accountInfo.layer.borderColor = UIColor.white.cgColor
				accountInfo.backgroundColor = UIColor.blue
				accountInfo.layer.cornerRadius = 15
			
				
				return accountInfo
			} else {
				let privacyInfo = collectionView.dequeueReusableCell(withReuseIdentifier: cellId4, for: indexPath) as! accountPrivacyCellDesign
				
				privacyInfo.accountPrivacyImages.image = UIImage(named: "lock")
				
				privacyInfo.backgroundColor = UIColor.blue
				
				privacyInfo.layer.cornerRadius = 5
				
				return privacyInfo
			}
			
		default:
			let cell2 = collectionView.dequeueReusableCell(withReuseIdentifier: cellId2, for: indexPath)
			return cell2
		}
	}
	
	
	//product Button
	@objc func handleProduct() {
		
		let cController = ProductVC(collectionViewLayout: UICollectionViewFlowLayout())
		self.navigationController?.pushViewController(cController, animated: true)
		
		print("Settings Tab is active")
	}
	
	@objc func handleSettings() {
		
		let cController = settings()
		cController.hidesBottomBarWhenPushed = true
		self.navigationController?.pushViewController(cController, animated: true)
		
		
		print("Settings Tab is active")
	}
	
	

	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		
		switch indexPath.section {
		case 0:
			
			handleProduct()
		case 1:
			
			if indexPath.item == 0 {
				handleProduct()
			} else {
				handleSearch()
			}
		case 2:
			
			handleSearch()
			
		case 3:
			
			if indexPath.item == 0 {
				handleSettings()
			} else {
				handlePrivacy()
			}
		default:
			handleSearch()
		}
	}
	
	// number of cells
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		
		switch section {
		case 0:
			
			return 1
		case 1:
			
			return 4
		case 3:
			return acct!.count
			
		default:
			return 1
		}
	}
	
	func numberOfSections(in collectionView: UICollectionView) -> Int {
		
		return 4
	}
	
	
	//inset allocation
	let sectionInsets = UIEdgeInsets(top: 2.5, left: 2.5, bottom: 2.5, right: 2.5)
	
	//trying to get spacing betweenc cells
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
		
		return sectionInsets.bottom
	}
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
		
		return sectionInsets
	}
	
	
	//size of each CollecionViewCell
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		
		switch indexPath.section {
		case 0:
			let userImageSection = CGSize(width: view.frame.width/2, height: 125) //125
			
			return userImageSection
			
		case 1:
			let size1 = CGSize(width: view.frame.width/4 - 10, height: 100)
			return size1
			
		case 2:
			let size2 = CGSize(width: view.frame.width - 10, height: 90)
			return size2
			
		case 3:
			let size4 = CGSize(width: view.frame.width/2 - 10, height: 130)
			return size4
			
		default:
			let defaults = CGSize(width: view.frame.width - 10, height: 110)
			return defaults
		}
	}
}



