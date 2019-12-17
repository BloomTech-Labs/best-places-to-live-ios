//
//  SignupVC.swift
//  BestPlaceToLive
//
//  Created by Jeffrey Santana on 11/11/19.
//  Copyright © 2019 bradleyyin. All rights reserved.
//

import UIKit
import AuthenticationServices

class SignupVC: UIViewController {
	
	// MARK: IBOutlets
	
	@IBOutlet weak var firstNameTextField: UITextField!
	@IBOutlet weak var lastNameTextField: UITextField!
	@IBOutlet weak var emailTextField: UITextField!
	@IBOutlet weak var passwordTextField: UITextField!
	@IBOutlet weak var buttonStackView: UIStackView!
	
	// MARK: Properties
	
	let settingsController = SettingsController.shared
	private lazy var signInWithAppleRequest: SignInWithAppleRequest = {
		let request = SignInWithAppleRequest(delegateVC: self, appleButtonType: .default, buttonStackView: self.buttonStackView)
		return request
	}()
	
	// MARK: Life Cycle
	
	override func viewDidLoad() {
		super.viewDidLoad()

		firstNameTextField.delegate = self
		lastNameTextField.delegate = self
		emailTextField.delegate = self
		passwordTextField.delegate = self
		
		settingsController.isSaveCredentials = true
//		signInWithAppleRequest.handleAppleIdRequest(userHasLoggedIn: true)
	}
	
	override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
		super.touchesBegan(touches, with: event)
		view.endEditing(true)
	}
	
	// MARK: IBActions
	
	@IBAction func signupBtnTapped(_ sender: Any) {
		guard
			let firstName = firstNameTextField.optionalText,
			let lastName = lastNameTextField.optionalText,
			let email = emailTextField.optionalText,
			let password = passwordTextField.optionalText
			else { return }
		let fullName = "\(firstName) \(lastName)"
		
		UserAPIController.shared.registerNewUser(name: fullName, email: email, password: password, appleId: nil) { (result) in
			switch result {
			case .success(let user):
				self.settingsController.persistcredentials(appleId: nil, email: email, password: password)
				self.settingsController.loginProcedure(user)
				
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
		if settingsController.loggedInUser != nil {
			let storyboard = UIStoryboard(name: "Profile", bundle: nil)
			
			if let initialVC = storyboard.instantiateInitialViewController() as? UINavigationController {
				guard let profileVC = initialVC.viewControllers.first as? ProfileVC else { return }
				
				navigationController?.viewControllers = [profileVC]
			}
		}
	}
	
}

// MARK: - Sign In With Apple Request Delegate

extension SignupVC: SignInWithAppleRequestDelegate {
	func navigate(to newVCStack: [UIViewController]) {
		navigationController?.viewControllers = newVCStack
	}
}

// MARK: - TextField Delegate

extension SignupVC: UITextFieldDelegate {
	func textFieldShouldReturn(_ textField: UITextField) -> Bool {
		switch textField {
		case firstNameTextField:
			lastNameTextField.becomeFirstResponder()
		case lastNameTextField:
			emailTextField.becomeFirstResponder()
		case emailTextField:
			passwordTextField.becomeFirstResponder()
		default:
			textField.resignFirstResponder()
		}
		return true
	}
}
