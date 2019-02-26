//
//  privacyTVC.swift
//  Adem
//
//  Created by Coleman Coats on 2/25/19.
//  Copyright © 2019 Coleman Coats. All rights reserved.
//

import Foundation
import UIKit

class privacyTVC: UITableViewController {
	
	//reuse ID's
	let privacy = "privacy"
	
	let privacyOptions = ["Download Data","Log out"]
	
	override func viewDidLoad() {
		super.viewDidLoad()
		let setText = UILabel()
		setText.text = "Privacy"
		setText.font = UIFont(name: "Lato", size: 20)
		setText.textColor = UIColor.black
		navigationItem.titleView = setText
		navigationController?.navigationBar.isTranslucent = false
		tableView.backgroundColor = UIColor.white
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
		
		
		return privacyOptions.count
	}
	
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		
		let dataSwitch = UISwitch()
		
		let privacy = tableView.dequeueReusableCell(withIdentifier: self.privacy, for: indexPath)
		privacy.textLabel?.text = privacyOptions[indexPath.row]
		privacy.textLabel?.textAlignment = .left
		privacy.backgroundColor = UIColor.white
		//privacy.textLabel?.font = .boldSystemFont(ofSize: 20)
		privacy.textLabel?.textColor = UIColor.black
		privacy.layer.cornerRadius = 5
		privacy.layer.borderWidth = 2
		privacy.layer.borderColor = UIColor.gray.cgColor
		privacy.accessoryView = dataSwitch
		
		return privacy
	}
	
	override func numberOfSections(in tableView: UITableView) -> Int {
		return 1
	}
	
	
}



