//
//  DynamicAttributes.swift
//  Adem
//
//  Created by Coleman Coats on 2/25/19.
//  Copyright © 2019 Coleman Coats. All rights reserved.
//

import Foundation
import UIKit
import FirebaseFirestore
import Firebase

//Product attributes
class itemCellContent: NSObject {
	
	
	var addItemButtonImage: String?
	var itemImageName: String?
	var itemName: String?
	var Quantity: String?
}

//Profile attributes
class profileContent: NSObject {
	
	
	var profileImage: String?
	var profielImageIdentifier: String?
	var personName: String?
}


//Account and Privacy attributes
class accountPrivacy: NSObject {
	
	var userprofileImage: String?
	var userNameLabel: String?
	var accountImage: String?
	var privacyImage: String?
}

//Device Attributes
class deviceContent: NSObject {
	
	var deviceImage: String?
	
}

struct thrownOutAlert: alertInformation {
	
	var alertProductName: String?
	var alertProductImageName: String?
	
}


//Alert Elements
class thrownOut: NSObject {
	
	
	var thrownItemImage: String?
	var thrownItemName: String?
}

class accountContent: NSObject {
	
	
	//	var docRef: DocumentReference!
	//
	//	docRef.getDocument(completion: { (docSnapshot, error) in
	//	guard let docSnapshot = docSnapshot, docSnapshot.exists else { return }
	//	let personNameData = docSnapshot.data()
	//	let nameData = personNameData?["Email"] as? String ?? ""
	//	})
	
	var personName: String?
	var profileImage: String?
	var devices: String?
	var family: String?
	var allergies: String?
}



