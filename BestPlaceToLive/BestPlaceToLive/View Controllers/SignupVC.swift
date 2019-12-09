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
	
	@IBOutlet weak var nameTextField: UITextField!
	@IBOutlet weak var emailTextField: UITextField!
	@IBOutlet weak var passwordTextField: UITextField!
	@IBOutlet weak var buttonStackView: UIStackView!
	
	// MARK: Properties
	
	let settingsController = SettingsController.shared
	private lazy var signInWithAppleRequest: SignInWithAppleRequest = {
		let request = SignInWithAppleRequest(delegateVC: self, buttonStackView: self.buttonStackView)
		return request
	}()
	
	// MARK: Life Cycle
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		settingsController.isSaveCredentials = true
		signInWithAppleRequest.handleAppleIdRequest(userHasLoggedIn: true)
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
	}
	
	// MARK: Helpers
	
	private func setUpSignInAppleButton() {
		let authorizationButton = ASAuthorizationAppleIDButton()
		
		authorizationButton.addTarget(self, action: #selector(signInWithAppleRequest.appleIDWrapper), for: .touchUpInside)
		authorizationButton.cornerRadius = 10
		
		let newIndex = buttonStackView.arrangedSubviews.endIndex
		buttonStackView.insertArrangedSubview(authorizationButton, at: newIndex)
		
		signInWithAppleRequest.delegate = self
	}
}

// MARK: - Sign In With Apple Request Delegate

extension SignupVC: SignInWithAppleRequestDelegate {
	func navigate(to newVCStack: [UIViewController]) {
		navigationController?.viewControllers = newVCStack
	}
}
