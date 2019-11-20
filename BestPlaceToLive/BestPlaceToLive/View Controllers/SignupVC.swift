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
	
	let settingsController = SettingsController.shared
	
	// MARK: Life Cycle
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		settingsController.isSaveCredentials = true
	}
	
	// MARK: IBActions
	
	@IBAction func signupBtnTapped(_ sender: Any) {
		guard
			let name = nameTextField.optionalText,
			let email = emailTextField.optionalText,
			let password = passwordTextField.optionalText
		else { return }
		
		UserAPIController.shared.registerNewUser(name: name, email: email, password: password) { (result) in
			switch result {
			case .success(let user):
				self.settingsController.persistcredentials(email, password)
				self.settingsController.loginProcedure(user)
			case .failure(let error):
				print(error)
			}	
		}
		
		#warning("Navigate to proper screen when signing up")
	}
	
	// MARK: Helpers

}
