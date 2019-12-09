//
//  SignInWithAppleRequest.swift
//  BestPlaceToLive
//
//  Created by Jeffrey Santana on 12/6/19.
//  Copyright © 2019 bradleyyin. All rights reserved.
//

import Foundation
import AuthenticationServices

protocol SignInWithAppleRequestDelegate {
	func navigate(to newVCStack: [UIViewController])
}

class SignInWithAppleRequest: NSObject {
	
	
	// MARK: IBOutlets
	
	
	// MARK: Properties
	
	let settingsController = SettingsController.shared
	var delegate: SignInWithAppleRequestDelegate?
	
	init(delegateVC: SignInWithAppleRequestDelegate, buttonStackView: UIStackView) {
		super.init()
		
		delegate = delegateVC
		setUpSignInAppleButton(in: buttonStackView)
	}
	
	// MARK: IBActions
	
	
	// MARK: Helpers
	
	func setUpSignInAppleButton(in buttonStackView: UIStackView) {
		let authorizationButton = ASAuthorizationAppleIDButton()
		
		authorizationButton.addTarget(self, action: #selector(appleIDWrapper), for: .touchUpInside)
		authorizationButton.cornerRadius = 10
		
		let newIndex = buttonStackView.arrangedSubviews.endIndex
		buttonStackView.insertArrangedSubview(authorizationButton, at: newIndex)
	}
	
	func handleAppleIdRequest(userHasLoggedIn: Bool) {
		var request: ASAuthorizationRequest
		
		if userHasLoggedIn {
			let authorizationPasswordRequest = ASAuthorizationPasswordProvider().createRequest()
			request = authorizationPasswordRequest
		} else {
			let authorizationAppleIDRequest = ASAuthorizationAppleIDProvider().createRequest()
			authorizationAppleIDRequest.requestedScopes = [.fullName, .email]
			request = authorizationAppleIDRequest
		}
		
		let authorizationController = ASAuthorizationController(authorizationRequests: [request])
		authorizationController.delegate = self
		authorizationController.presentationContextProvider = self
		authorizationController.performRequests()
	}
	
	@objc func appleIDWrapper() {
		handleAppleIdRequest(userHasLoggedIn: false)
	}
	
	private func handle(appleIDCredential: ASAuthorizationAppleIDCredential) {
		let userIdentifier = appleIDCredential.user
		print("User ID: \(appleIDCredential.user)")
		
		if let userEmail = appleIDCredential.email {
			print("Email: \(userEmail)")
		}
		
		if let userGivenName = appleIDCredential.fullName?.givenName,
			let userFamilyName = appleIDCredential.fullName?.familyName {
			print("Given Name: \(userGivenName)")
			print("Family Name: \(userFamilyName)")
		}
		
		if let authorizationCode = appleIDCredential.authorizationCode,
			let identifyToken = appleIDCredential.identityToken {
			print("Authorization Code: \(authorizationCode)")
			print("Identity Token: \(identifyToken)")
			//First time user, perform authentication with the backend
			//TODO: Submit authorization code and identity token to your backend for user validation and signIn
		}
		
		let appleIDProvider = ASAuthorizationAppleIDProvider()
		appleIDProvider.getCredentialState(forUserID: userIdentifier) { (credentialState, error) in
			switch credentialState {
			case .authorized:
				if let email = appleIDCredential.email, let nameComponents = appleIDCredential.fullName {
					let fullName = PersonNameComponentsFormatter().string(from: nameComponents)
					
					UserAPIController.shared.registerNewUser(name: fullName, email: email, password: userIdentifier) { (result) in
						switch result {
						case .success(let user):
							self.settingsController.persistcredentials(email, userIdentifier)
							self.settingsController.loginProcedure(user)
							DispatchQueue.main.async {
								self.segueToProfileVC()
							}
						case .failure(let error):
							print(error)
						}
					}
				} else {
					
				}
				break
			case .revoked:
				// The Apple ID credential is revoked. Show SignIn UI Here.
				break
			case .notFound:
				// No credential was found. Show SignIn UI Here.
				break
			default:
				break
			}
		}
	}
	
	private func handle(passwordCredential: ASPasswordCredential) {
		print("User: \(passwordCredential.user)")
		print("Password: \(passwordCredential.password)")
		
		//TODO: Fill your email/password fields if you have it and submit credentials securely to your server for authentication
	}
	
	private func segueToProfileVC() {
		if SettingsController.shared.loggedInUser != nil {
			let storyboard = UIStoryboard(name: "Profile", bundle: nil)
			
			if let initialVC = storyboard.instantiateInitialViewController() as? UINavigationController {
				guard let optionsVC = initialVC.viewControllers.first as? ProfileVC else { return }
				
				delegate?.navigate(to: [optionsVC])
			}
		}
	}
}

// MARK: - AS Authorization Controller Delegate

extension SignInWithAppleRequest: ASAuthorizationControllerDelegate {
	
	func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
		switch authorization.credential {
		case let appleIDCredential as ASAuthorizationAppleIDCredential:
			handle(appleIDCredential: appleIDCredential)
		case let passwordCredential as ASPasswordCredential:
			handle(passwordCredential: passwordCredential)
		default: break
		}
	}
	
	func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
		print("Apple sign-in went wrong: \(error)")
	}
}

// MARK: - AS Authorization Controller Presentation Context Providing

extension SignInWithAppleRequest: ASAuthorizationControllerPresentationContextProviding {
	func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
		if let window = UIApplication.shared.windows.first {
			return window
		}
		return ASPresentationAnchor()
	}
}

