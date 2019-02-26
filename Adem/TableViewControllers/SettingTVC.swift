
//
//  SettingTVC.swift
//  Adem
//
//  Created by Coleman Coats on 2/25/19.
//  Copyright © 2019 Coleman Coats. All rights reserved.
//

import Foundation
import UIKit

class SettingTVC: UITableViewController {
	
	//reuse ID's
	let privacy = "privacy"
	
	let settingsOptions = ["Log out"]
	
	override func viewDidLoad() {
		super.viewDidLoad()
		let setText = UILabel()
		setText.text = "Settings"
		setText.font = UIFont(name: "Lato", size: 20)
		setText.textColor = UIColor.rgb(red: 30, green: 188, blue: 29)
		navigationItem.titleView = setText
		navigationController?.navigationBar.isTranslucent = false
		tableView.backgroundColor = UIColor.rgb(red: 46, green: 114, blue: 111)
		tableView.register(UITableViewCell.self, forCellReuseIdentifier: privacy)
		
	}
	
	//product Button
	@objc func handleProduct() {
		
		let cController = ProductVC(collectionViewLayout: UICollectionViewFlowLayout())
		self.navigationController?.pushViewController(cController, animated: true)
		
		print("Settings Tab is active")
	}
	
	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		switch indexPath.row {
		case 0:
			handleProduct()
		default:
			handleProduct()
		}
	}
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		
		
		return settingsOptions.count
	}
	
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		
		let privacy = tableView.dequeueReusableCell(withIdentifier: self.privacy, for: indexPath)
		privacy.textLabel?.text = settingsOptions[indexPath.row]
		privacy.textLabel?.textAlignment = .center
		privacy.backgroundColor = UIColor.rgb(red: 46, green: 114, blue: 111)
		privacy.textLabel?.font = .boldSystemFont(ofSize: 20)
		privacy.textLabel?.textColor = UIColor.white
		return privacy
	}
	
	
	
	override func numberOfSections(in tableView: UITableView) -> Int {
		return 1
	}
	
	
}


