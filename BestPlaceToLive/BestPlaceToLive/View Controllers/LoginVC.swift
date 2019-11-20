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
				DispatchQueue.main.async {
					self.segueToProfileVC()
				}
			case .failure(let error):
				print(error)
			}			
		}
	}
	
	// MARK: Helpers
	
	private func segueToProfileVC() {
		if SettingsController.shared.loggedInUser != nil {
			let storyboard = UIStoryboard(name: "Profile", bundle: nil)
			
			if let initialVC = storyboard.instantiateInitialViewController() as? UINavigationController {
					guard let optionsVC = initialVC.viewControllers.first as? ProfileVC else { return }
				
				navigationController?.viewControllers = [optionsVC]
			}
		}
	}
	
	
}
