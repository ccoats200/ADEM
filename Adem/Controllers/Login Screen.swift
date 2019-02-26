//
//  Login Screen.swift
//  Adem
//
//  Created by Coleman Coats on 2/25/19.
//  Copyright © 2019 Coleman Coats. All rights reserved.
//

import UIKit
import Foundation
import Firebase
import FirebaseFirestore


class login: UIViewController, UITextFieldDelegate {
	
	// Add a new document with a generated ID
	var docRef: DocumentReference!
	var handle: AuthStateDidChangeListenerHandle?
	let user = Auth.auth().currentUser
	let minimuPasswordCount = 6
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		docRef = Firestore.firestore().document("\(userNames)")
		
		emailTextField.delegate = self
		passwordTextField.delegate = self
		
		
		let gradient = CAGradientLayer()
		gradient.frame = view.bounds
		gradient.colors = [UIColor.rgb(red: 59, green: 94, blue: 101).cgColor,UIColor.rgb(red: 30, green: 188, blue: 29).cgColor]
		//Top left
		gradient.startPoint = CGPoint(x: 0, y: 0)
		//Top right
		gradient.endPoint = CGPoint(x: 1, y: 1)
		view.layer.addSublayer(gradient)
		
		
		view.addSubview(facebookLoginImage)
		view.addSubview(loginFieldView)
		view.addSubview(ademImageHolder)
		view.addSubview(loginButton)
		view.addSubview(signUpButton)
		
		//setupademImageHolder()
		setuploginFieldView()
		setuploginRegisterButton()
		
	}
	
	
	
	
	let loginFieldView: UIView = {
		let logintextfield = UIView()
		logintextfield.backgroundColor = UIColor.white
		logintextfield.translatesAutoresizingMaskIntoConstraints = false
		logintextfield.layer.cornerRadius = 5
		logintextfield.layer.masksToBounds = true
		return logintextfield
	}()
	
	lazy var loginButton: UIButton = {
		let login = UIButton(type: .system)
		login.backgroundColor = UIColor.white
		login.setTitle("Login", for: .normal)
		login.translatesAutoresizingMaskIntoConstraints = false
		login.layer.cornerRadius = 5
		login.layer.masksToBounds = true
		login.setTitleColor(UIColor.rgb(red: 76, green: 82, blue: 111), for: .normal)
		login.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
		login.addTarget(self, action: #selector(handelLogin), for: .touchUpInside)
		return login
		
	}()
	
	lazy var signUpButton: UIButton = {
		let signUp = UIButton(type: .system)
		signUp.setTitle("Sign up", for: .normal)
		signUp.translatesAutoresizingMaskIntoConstraints = false
		signUp.setTitleColor(UIColor.white, for: .normal)
		signUp.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
		signUp.addTarget(self, action: #selector(handelSignUp), for: .touchUpInside)
		return signUp
		
	}()
	
	lazy var facebookLoginImage: UIButton = {
		let facebookLogin = UIButton(type: .system)
		facebookLogin.setImage(UIImage.init(named: "Home"), for: .normal)
		facebookLogin.translatesAutoresizingMaskIntoConstraints = false
		facebookLogin.addTarget(self, action: #selector(handleSkip), for: .touchUpInside)
		return facebookLogin
	}()
	
	
	/*
	//pull this info into the account section
	func setTitleDisplay(_ user: User?) {
	if let name = user?.displayName {
	self.navigationItem.title = "Welcome \(name)"
	} else {
	self.navigationItem.title = "Welcome to Adem"
	}
	
	}
	
	
	//Authentication State listner
	override func viewWillAppear(_ animated: Bool) {
	super.viewWillAppear(animated)
	handle = Auth.auth().addStateDidChangeListener { (auth, User) in
	self.setTitleDisplay(User)
	}
	}
	override func viewWillDisappear(_ animated: Bool) {
	super.viewWillDisappear(animated)
	Auth.auth().removeStateDidChangeListener(handle!)
	}
	*/
	
	
	
	@objc func handelLogin()
	{
		
		guard let email = emailTextField.text, !email.isEmpty else { return }
		guard let password = passwordTextField.text, !password.isEmpty else { return }
		
		print(email)
		print(password)
		
		//User: Created with email
		Auth.auth().signIn(withEmail: emailTextField.text!, password: passwordTextField.text!)
		
		let appDelegate = UIApplication.shared.delegate as! AppDelegate
		
		
		let listController = CustomCollecCellDesign(collectionViewLayout: UICollectionViewFlowLayout())
		//self.navigationController?.pushViewController(listController, animated: true)
		//self.tabBarController?.present(listController, animated: true, completion: nil)
		
		appDelegate.window?.rootViewController = listController
		appDelegate.window?.makeKeyAndVisible()
		
		
		
		print("Logging in")
	}
	
	
	
	@objc func handelSignUp()
	{
		
		/*
		print(" tapped sign up button")
		
		print(minimuPasswordCount)
		
		
		
		//guard let user = AuthDataResult?.user else { return }
		guard let email = emailTextField.text, !email.isEmpty else { return }
		guard let password = passwordTextField.text, !password.isEmpty else { return }
		
		print(email)
		print(password)
		
		Auth.auth().createUser(withEmail: emailTextField.text!, password: passwordTextField.text!)
		
		let dataToSave: [String: Any] = ["Email": email, "Password": password]
		docRef.setData(dataToSave) { (error) in
		if let error = error {
		print("Error getting documents: \(error.localizedDescription)")
		} else {
		print("Data has been Saved")
		}
		}
		*/
		
		
		let signUpInfo = UserInfo()
		self.present(signUpInfo, animated: true, completion: nil)
		//self.navigationController?.pushViewController(signUpInfo, animated: true)
		print("Sending user to sign up Flow")
		
	}
	
	@objc func handleSkip()
	{
		
		let signUpInfo = CustomCollecCellDesign()
		self.navigationController?.pushViewController(signUpInfo, animated: true)
		print("Allowing user to skip the login or sign up flow")
		
	}
	
	func textFieldShouldReturn(_ textField: UITextField) -> Bool {
		emailTextField.resignFirstResponder()
		passwordTextField.resignFirstResponder()
		return true
	}
	
	override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
		self.view.endEditing(true)
	}
	
	let userNameTextField: UITextField = {
		let name = UITextField()
		name.placeholder = "User Name"
		name.translatesAutoresizingMaskIntoConstraints = false
		
		return name
	}()
	
	let emailTextField: UITextField = {
		let email = UITextField()
		email.placeholder = "Email"
		email.translatesAutoresizingMaskIntoConstraints = false
		return email
	}()
	
	let emailTextSeparator: UIView = {
		let textSeparator = UIView()
		textSeparator.backgroundColor = UIColor.lightGray
		textSeparator.translatesAutoresizingMaskIntoConstraints = false
		//textSeparator.centerXAnchor.constraint(equalTo: textSeparator.centerXAnchor).isActive = true
		//textSeparator.widthAnchor.constraint(equalTo: textSeparator.widthAnchor, constant: -24).isActive = true
		return textSeparator
	}()
	
	let passwordTextField: UITextField = {
		let password = UITextField()
		password.placeholder = "Password"
		password.isSecureTextEntry = true
		password.translatesAutoresizingMaskIntoConstraints = false
		
		return password
	}()
	
	let passwordTextSeparator: UIView = {
		let passwordSeparator = UIView()
		passwordSeparator.backgroundColor = UIColor.lightGray
		passwordSeparator.translatesAutoresizingMaskIntoConstraints = false
		
		return passwordSeparator
	}()
	
	let ademImageHolder: UIImageView = {
		let ademImage = UIImageView()
		ademImage.image = UIImage(named: "Adem Logo")
		ademImage.translatesAutoresizingMaskIntoConstraints = false
		ademImage.contentMode = .scaleAspectFit
		
		return ademImage
	}()
	
	func setuploginFieldView() {
		
		ademImageHolder.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
		ademImageHolder.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 5).isActive = true
		ademImageHolder.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -24).isActive = true
		ademImageHolder.heightAnchor.constraint(equalToConstant: 255).isActive = true
		
		//login Fields
		loginFieldView.topAnchor.constraint(equalTo: ademImageHolder.bottomAnchor, constant: 55).isActive = true
		loginFieldView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
		loginFieldView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
		loginFieldView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -24).isActive = true
		loginFieldView.heightAnchor.constraint(equalToConstant: 95).isActive = true //125 also looks good
		
		//loginFieldView.addSubview(userNameTextField)
		loginFieldView.addSubview(emailTextField)
		loginFieldView.addSubview(emailTextSeparator)
		loginFieldView.addSubview(passwordTextField)
		
		
		//Email text
		emailTextField.leftAnchor.constraint(equalTo: loginFieldView.leftAnchor, constant: 12).isActive = true
		emailTextField.topAnchor.constraint(equalTo: loginFieldView.topAnchor).isActive = true
		emailTextField.widthAnchor.constraint(equalTo: loginFieldView.widthAnchor, constant: -24).isActive = true
		emailTextField.heightAnchor.constraint(equalTo: loginFieldView.heightAnchor, multiplier: 1/2).isActive = true
		
		//Name separator
		emailTextSeparator.leftAnchor.constraint(equalTo: loginFieldView.leftAnchor).isActive = true
		emailTextSeparator.topAnchor.constraint(equalTo: emailTextField.bottomAnchor).isActive = true
		emailTextSeparator.widthAnchor.constraint(equalTo: loginFieldView.widthAnchor).isActive = true
		emailTextSeparator.heightAnchor.constraint(equalToConstant: 1).isActive = true
		
		//Password text
		passwordTextField.leftAnchor.constraint(equalTo: loginFieldView.leftAnchor, constant: 12).isActive = true
		passwordTextField.topAnchor.constraint(equalTo: emailTextSeparator.topAnchor).isActive = true
		passwordTextField.widthAnchor.constraint(equalTo: loginFieldView.widthAnchor, constant: -24).isActive = true
		passwordTextField.heightAnchor.constraint(equalTo: loginFieldView.heightAnchor, multiplier: 1/2).isActive = true
		
	}
	
	
	func setuploginRegisterButton() {
		loginButton.centerXAnchor.constraint(equalTo: loginFieldView.centerXAnchor).isActive = true
		loginButton.topAnchor.constraint(equalTo: loginFieldView.bottomAnchor, constant: 12).isActive = true
		loginButton.widthAnchor.constraint(equalTo: loginFieldView.widthAnchor).isActive = true
		loginButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
		
		signUpButton.centerXAnchor.constraint(equalTo: loginFieldView.centerXAnchor).isActive = true
		signUpButton.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 12).isActive = true
		signUpButton.widthAnchor.constraint(equalToConstant: 60).isActive = true
		signUpButton.heightAnchor.constraint(equalToConstant: 10).isActive = true
		
		
		facebookLoginImage.centerXAnchor.constraint(equalTo: loginFieldView.centerXAnchor).isActive = true
		facebookLoginImage.topAnchor.constraint(equalTo: signUpButton.bottomAnchor, constant: 12).isActive = true
		facebookLoginImage.widthAnchor.constraint(equalToConstant: 60).isActive = true
		facebookLoginImage.heightAnchor.constraint(equalToConstant: 60).isActive = true
	}
}
