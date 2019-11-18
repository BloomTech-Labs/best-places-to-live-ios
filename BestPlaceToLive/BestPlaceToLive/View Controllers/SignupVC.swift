//
//  SignupVC.swift
//  BestPlaceToLive
//
//  Created by Jeffrey Santana on 11/11/19.
//  Copyright © 2019 bradleyyin. All rights reserved.
//

import UIKit

class SignupVC: UIViewController {

	// MARK: IBOutlets
	
	@IBOutlet weak var nameTextField: UITextField!
	@IBOutlet weak var emailTextField: UITextField!
	@IBOutlet weak var passwordTextField: UITextField!
	
	// MARK: Properties
	
	
	// MARK: Life Cycle
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		
	}
	
	// MARK: IBActions
	
	@IBAction func signupBtnTapped(_ sender: Any) {
		guard
			let name = nameTextField.optionalText,
			let email = emailTextField.optionalText,
			let password = passwordTextField.optionalText
		else { return }
		
		APIController.shared.registerNewUser(name: name, email: email, password: password) { (result) in
			switch result {
			case .success(let user):
				SettingsController.shared.loginProcedure(user)
			case .failure(let error):
				print(error)
			}	
		}
		
		#warning("Navigate to proper screen when signing up")
	}
	
	// MARK: Helpers

}
