//
//  ItemVCLayout.swift
//  Adem
//
//  Created by Coleman Coats on 2/26/19.
//  Copyright © 2019 Coleman Coats. All rights reserved.
//

import Foundation
import UIKit
import Firebase
import FirebaseFirestore


class productVCLayout: UIViewController {
	
	
	// Add a new document with a generated ID
	var docRef: DocumentReference!
	var handle: AuthStateDidChangeListenerHandle?
	let user = Auth.auth().currentUser
	let minimuPasswordCount = 6
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		let titleText = UILabel()
		titleText.text = "Blueberies"
		titleText.font = UIFont(name: "Lato", size: 20)
		//titleText.textColor = UIColor.rgb(red: 30, green: 188, blue: 29)
		titleText.textColor = UIColor.white
		navigationItem.titleView = titleText
		navigationController?.navigationBar.isTranslucent = true
		//navigationController?.navigationBar.alpha = 2.0
		
		scrolling.isScrollEnabled = true
		
		view.backgroundColor = UIColor.rgb(red: 30, green: 188, blue: 29)
		
		
		
		view.addSubview(scrolling)

//		setuploginFieldView()
//		setupproductInfoHolder()
//		setupproductNutritionLabel()
		setUpScrollView()
	}
	
	let scrolling: UIScrollView = {
		let scrollable = UIScrollView()
		scrollable.backgroundColor = UIColor.clear
		scrollable.translatesAutoresizingMaskIntoConstraints = false
		scrollable.contentSize.height = 1000
		//scrollable.isScrollEnabled = true
		return scrollable
	}()
	
	
	let backgrounLightColor: UIView = {
		let lightColor = UIView()
		lightColor.backgroundColor = UIColor.rgb(red: 54, green: 195, blue: 52)
		//logintextfield.layer.opacity = 2.0
		lightColor.translatesAutoresizingMaskIntoConstraints = false
		lightColor.layer.masksToBounds = true
		
		return lightColor
	}()
	
	let productImage: UIImageView = {
		let productImageDesign = UIImageView()
		productImageDesign.image = UIImage(named: "blueBerry")
		productImageDesign.contentMode = .center
		productImageDesign.contentMode = .scaleAspectFill
		productImageDesign.clipsToBounds = true
		productImageDesign.layer.masksToBounds = true
		productImageDesign.layer.cornerRadius = 25
		productImageDesign.layer.borderWidth = 1
		productImageDesign.layer.borderColor = UIColor.white.cgColor
		productImageDesign.translatesAutoresizingMaskIntoConstraints = false
		print("Created Image for the product image in the details VC")
		
		return productImageDesign
	}()
	
	let productNutritionInfo: UIImageView = {
		let nutritionLabels = UIImageView()
		nutritionLabels.image = UIImage(named: "Check")
		nutritionLabels.translatesAutoresizingMaskIntoConstraints = false
		nutritionLabels.contentMode = .scaleAspectFit
		nutritionLabels.backgroundColor = UIColor.blue
		nutritionLabels.layer.cornerRadius = 12.5
		
		return nutritionLabels
	}()
	
	
	let productInfoHolder: UIView = {
		let productInfo = UIView()
		productInfo.backgroundColor = UIColor.white
		productInfo.translatesAutoresizingMaskIntoConstraints = false
		productInfo.layer.cornerRadius = 5
		productInfo.layer.masksToBounds = true
		return productInfo
	}()
	
	let calLabel: UILabel = {
		let calories = UILabel()
		//calories.backgroundColor = UIColor.blue
		calories.translatesAutoresizingMaskIntoConstraints = false
		calories.layer.cornerRadius = 5
		calories.layer.masksToBounds = true
		calories.text = "Calories: "
		return calories
	}()

	//var cost = 2.99
	
	let priceLabel: UILabel = {
		let cost = 2.99
		let price = UILabel()
		price.translatesAutoresizingMaskIntoConstraints = false
		price.layer.cornerRadius = 5
		price.layer.masksToBounds = true
		price.text = "$\(cost)"
		return price
	}()
	
	
	let NurtritionLabel: UIView = {
		let NutLbl = UITextView()
		NutLbl.font = UIFont(name: "Helvetica", size: 15)
		NutLbl.backgroundColor = UIColor.rgb(red: 241, green: 249, blue: 253)
		NutLbl.isEditable = false
		NutLbl.text = "This is a test to see if I can pre populate the text with the ingrediants"
		NutLbl.textAlignment = .left
		NutLbl.layer.cornerRadius = 2
		NutLbl.layer.borderWidth = 0.1
		NutLbl.translatesAutoresizingMaskIntoConstraints = false
		
		return NutLbl
	}()
	
	func setUpScrollView() {
		scrolling.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
		scrolling.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
		scrolling.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
		
		scrolling.addSubview(backgrounLightColor)
		scrolling.addSubview(productInfoHolder)
		scrolling.addSubview(NurtritionLabel)
		scrolling.addSubview(productImage)
		//Adding subviews
		scrolling.addSubview(productNutritionInfo)
		scrolling.addSubview(calLabel)
		scrolling.addSubview(priceLabel)
		
		setuploginFieldView()
		setupproductInfoHolder()
		setupproductNutritionLabel()
	}
	
	
	func setuploginFieldView() {
		
		
		backgrounLightColor.topAnchor.constraint(equalTo: scrolling.topAnchor, constant: 5).isActive = true
		backgrounLightColor.centerXAnchor.constraint(equalTo: scrolling.centerXAnchor).isActive = true
		backgrounLightColor.widthAnchor.constraint(equalTo: scrolling.widthAnchor, constant: -50).isActive = true
		backgrounLightColor.heightAnchor.constraint(equalToConstant: 300).isActive = true
		backgrounLightColor.layer.cornerRadius = 150 //(view.frame.width + -50)/2
		
		//Image added
		
		
		
		//login Fields
		//productImage.topAnchor.constraint(equalTo: backgrounLightColor.topAnchor, constant: 5).isActive = true
		productImage.centerXAnchor.constraint(equalTo: backgrounLightColor.centerXAnchor).isActive = true
		productImage.centerYAnchor.constraint(equalTo: backgrounLightColor.centerYAnchor).isActive = true
		productImage.widthAnchor.constraint(equalToConstant: 200).isActive = true
		productImage.heightAnchor.constraint(equalToConstant: 200).isActive = true //125 also looks good
		
		
	}
	
	
	
	
	
	func setupproductInfoHolder() {
		
		productInfoHolder.topAnchor.constraint(equalTo: backgrounLightColor.bottomAnchor, constant: 5).isActive = true
		productInfoHolder.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
		productInfoHolder.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -50).isActive = true
		productInfoHolder.heightAnchor.constraint(equalToConstant: 300).isActive = true
		productInfoHolder.layer.cornerRadius = 10
		
		
		
		//nutrition labels
		productNutritionInfo.topAnchor.constraint(equalTo: productInfoHolder.topAnchor, constant: 5).isActive = true
		productNutritionInfo.rightAnchor.constraint(equalTo: productInfoHolder.rightAnchor, constant: -10).isActive = true
		productNutritionInfo.widthAnchor.constraint(equalToConstant: 25).isActive = true
		productNutritionInfo.heightAnchor.constraint(equalToConstant: 25).isActive = true
		
		//calories
		calLabel.topAnchor.constraint(equalTo: productNutritionInfo.bottomAnchor, constant: 5).isActive = true
		calLabel.leftAnchor.constraint(equalTo: productInfoHolder.leftAnchor, constant: 12).isActive = true
		calLabel.widthAnchor.constraint(equalToConstant: 75).isActive = true
		calLabel.heightAnchor.constraint(equalToConstant: 25).isActive = true
		
		//calories
		priceLabel.topAnchor.constraint(equalTo: productNutritionInfo.bottomAnchor, constant: 5).isActive = true
		priceLabel.rightAnchor.constraint(equalTo: productInfoHolder.rightAnchor, constant: 12).isActive = true
		priceLabel.widthAnchor.constraint(equalToConstant: 75).isActive = true
		priceLabel.heightAnchor.constraint(equalToConstant: 25).isActive = true
		
	}
	
	func setupproductNutritionLabel() {
		
		NurtritionLabel.topAnchor.constraint(equalTo: productInfoHolder.bottomAnchor, constant: 5).isActive = true
		NurtritionLabel.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
		NurtritionLabel.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -50).isActive = true
		NurtritionLabel.heightAnchor.constraint(equalToConstant: 300).isActive = true
		NurtritionLabel.layer.cornerRadius = 10
		
	}

	
}
