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
	private lazy var signInWithAppleRequest: SignInWithAppleRequest = {
		let request = SignInWithAppleRequest(delegateVC: self, appleButtonType: .continue, buttonStackView: self.buttonStackView)
		return request
	}()
	
	// MARK: Life Cycle
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		settingsController.isSaveCredentials = true
		signInWithAppleRequest.handleAppleIdRequest(userHasLoggedIn: true)
	}
	
	// MARK: IBActions
	
	@IBAction func loginBtnTapped(_ sender: Any) {
		guard
			let email = emailTextField.optionalText,
			let password = passwordTextField.optionalText
		else { return }
		
		loginUser(email: email, password: password)
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
	
	private func loginUser(email: String, password: String) {
		UserAPIController.shared.login(email: email, password: password) { (result) in
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
}

// MARK: - Sign In With Apple Request Delegate

extension LoginVC: SignInWithAppleRequestDelegate {
	func navigate(to newVCStack: [UIViewController]) {
		navigationController?.viewControllers = newVCStack
	}
}
