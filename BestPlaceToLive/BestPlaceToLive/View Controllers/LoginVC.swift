//
//  LoginVC.swift
//  BestPlaceToLive
//
//  Created by Jeffrey Santana on 11/11/19.
//  Copyright © 2019 bradleyyin. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {

	// MARK: IBOutlets
	
	@IBOutlet weak var emailTextField: UITextField!
	@IBOutlet weak var passwordTextField: UITextField!
	
	// MARK: Properties
	
	
	// MARK: Life Cycle
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		
	}
	
	// MARK: IBActions
	
	@IBAction func loginBtnTapped(_ sender: Any) {
		guard
			let email = emailTextField.optionalText,
			let password = passwordTextField.optionalText
		else { return }
		
		UserAPIController.shared.login(email: email, password: password) { (result) in
			switch result {
			case .success(let user):
				SettingsController.shared.loginProcedure(user)
			case .failure(let error):
				print(error)
			}			
		}
		
		#warning("Navigate to proper screen when logging in")
	}
	
	// MARK: Helpers
	
	
}
