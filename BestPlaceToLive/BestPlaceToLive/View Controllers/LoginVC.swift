//
//  LoginVC.swift
//  BestPlaceToLive
//
//  Created by Jeffrey Santana on 11/11/19.
//  Copyright © 2019 bradleyyin. All rights reserved.
//

import UIKit
import AuthenticationServices

class LoginVC: UIViewController {

	// MARK: IBOutlets
	
	@IBOutlet weak var emailTextField: UITextField!
	@IBOutlet weak var passwordTextField: UITextField!
	@IBOutlet weak var buttonStackView: UIStackView!
	
	// MARK: Properties
	
	private let settingsController = SettingsController.shared
	private var signInWithAppleRequest = SignInWithAppleRequest()
	
	// MARK: Life Cycle
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		settingsController.isSaveCredentials = true
		
		setUpSignInAppleButton()
		signInWithAppleRequest.handleAppleIdRequest(userHasLoggedIn: true)
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
				self.settingsController.persistcredentials(email, password)
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
	
	private func setUpSignInAppleButton() {
		let authorizationButton = ASAuthorizationAppleIDButton()
		
		authorizationButton.addTarget(self, action: #selector(appleIDWrapper), for: .touchUpInside)
		authorizationButton.cornerRadius = 10
		
		let newIndex = buttonStackView.arrangedSubviews.endIndex
		buttonStackView.insertArrangedSubview(authorizationButton, at: newIndex)
		
		signInWithAppleRequest.delegate = self
	}
	
	@objc private func appleIDWrapper() {
		signInWithAppleRequest.handleAppleIdRequest(userHasLoggedIn: false)
	}
	
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

// MARK: - Sign In With Apple Request Delegate

extension LoginVC: SignInWithAppleRequestDelegate {
	func navigate(to newVCStack: [UIViewController]) {
		navigationController?.viewControllers = newVCStack
	}
}
