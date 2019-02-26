//
//  tabController.swift
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


class tabBar: UITabBarController, UICollectionViewDelegateFlowLayout {
	
	
	let cellID = "products"
	
	
	let tabBarButtonNames = ["Home", "Pantry_new", "lock", "Knife_Lrg"]
	
	
	
	override func viewDidLoad() {
		super.viewDidLoad()
		//tabBar.barTintColor = UIColor.rgb(red: 30, green: 188, blue: 29)
		//tabBar.backgroundColor = UIColor.rgb(red: 30, green: 188, blue: 29)
		tabBar.backgroundColor = UIColor.white
		
		
		self.tabBarItem.imageInsets = UIEdgeInsets(top: 6, left: 0, bottom: -6, right: 0)
		//self.title = nil
		
		//List
		let layout = UICollectionViewFlowLayout()
		let listController = CustomCollecCellDesign(collectionViewLayout: layout)
		let listTabButton = UINavigationController(rootViewController: listController)
		//listTabButton.tabBarItem.title = "List"
		//listTabButton.tabBarItem.image = UIImage(named: "Pantry_new")
		//listTabButton.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 2)
		//listTabButton.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "Pantry_new"), selectedImage: UIImage(named: "Pantry_new"))
		listTabButton.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "Home"), tag: 2)
		listTabButton.tabBarItem.imageInsets = UIEdgeInsets(top: 6, left: 0, bottom: -6, right: 0)
		
		
		//Pantry
		let pantryController = PantryVC(collectionViewLayout: layout)
		let pantryTabButton = UINavigationController(rootViewController: pantryController)
		pantryTabButton.tabBarItem.title = "Panrty"
		//pantryTabButton.tabBarItem = UITabBarItem(tabBarSystemItem: .history, tag: 2)
		pantryTabButton.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "Pantry_new"), tag: 2)
		pantryTabButton.tabBarItem.imageInsets = UIEdgeInsets(top: 6, left: 0, bottom: -6, right: 0)
		
		
		//Meals
		let mealsController = Meals(collectionViewLayout: layout)
		let mealsTabButton = UINavigationController(rootViewController: mealsController)
		//mealsTabButton.tabBarItem.title = "home"
		mealsTabButton.tabBarItem = UITabBarItem(title: "Meals", image: UIImage(named: "Knife_Lrg"), tag: 2)
		//mealsTabButton.tabBarItem = UITabBarItem(tabBarSystemItem: .history, tag: 2)
		mealsTabButton.tabBarItem.imageInsets = UIEdgeInsets(top: 6, left: 0, bottom: -6, right: 0)
		
		//Navigation Items
		navigationItem.title = "List"
		navigationController?.navigationBar.isTranslucent = false
		
		//Collection Items
		
		
		//Instantiation
		//setUpTabBar()
		
		viewControllers = [listTabButton, pantryTabButton, mealsTabButton]
		
		let isLoggedIn = true
		
		if isLoggedIn {
			
		} else {
			perform(#selector(sendToLogin), with: nil, afterDelay: 0.01)
		}
		
		
	}
	
	
	@objc func sendToLogin() {
		let loginController = login()
		present(loginController, animated: true, completion: {
			
		})
	}
	
	private func tabControllerTemplate(title: String, imageName: String) -> UINavigationController {
		let viewController = UIViewController()
		let navController = UINavigationController(rootViewController: viewController)
		navController.tabBarItem.title = title
		navController.tabBarItem.image = UIImage(named: imageName)
		return navController
	}
	
}

/*
//NavigationbarItems
func setUpNavBarButton() {
let accountImage = UIBarButtonItem(image: UIImage(named: "Knife")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(handleAccount))


let searchImage = UIBarButtonItem(image: UIImage(named: "search")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(handleSearch))


navigationItem.leftBarButtonItem = accountImage
navigationItem.rightBarButtonItem = searchImage
}

//Account Button
@objc func handleAccount() {

//This is for the multiple collection views, horizontal and vertical
let aController = AccountVC()

//This is for the custome collection view Add button image for profile image

//let aController = AccountVC(collectionViewLayout: UICollectionViewFlowLayout())
self.navigationController?.pushViewController(aController, animated: true)
//self.present(aController, animated: true, completion: nil)
print("Acccount tab is active")
}

//product Button
@objc func handleProduct() {

let cController = ProductVC(collectionViewLayout: UICollectionViewFlowLayout())
self.navigationController?.pushViewController(cController, animated: true)

print("Settings Tab is active")
}

//NavigationBarItems

//Search Button
@objc func handleSearch() {
//let cController = SettingsVC()
let cController = login()
self.navigationController?.pushViewController(cController, animated: true)
print("Settings Tab is active")
}

func setUpCollectionView() {
view.addSubview(collection)


collection.delegate = self
//collection.dataSource = self


//collection.widthAnchor.constraint(equalTo: view.frame.width).isActive = true
//collection.heightAnchor.constraint(equalTo: view.frame.height).isActive = true

}


func setUpTabBar() {
let pantryController = UINavigationController(rootViewController: ItemVC())
pantryController.tabBarItem.image = UIImage(named: "Home")
pantryController.tabBarItem.selectedImage = UIImage(named: "pantry")

viewControllers = [pantryController]

}


let collection: UICollectionView = {
let listItems = Collection()
listItems.backgroundColor = UIColor.blue


return listItems
}()


}



class Collection: UICollectionView {




/*
let cellID = "products"

func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

return 4
}

func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

let productCell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! productCellLayout
productCell.backgroundColor = UIColor.rgb(red: 252, green: 252, blue: 252) //off white blue color
productCell.layer.cornerRadius = 5
print("Rounds corners")


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



//Space between rows
func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
return 25
}

func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
return 0
}
*/
}
*/
