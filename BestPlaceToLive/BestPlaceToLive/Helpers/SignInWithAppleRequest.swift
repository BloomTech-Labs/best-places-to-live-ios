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
	var buttonType: ASAuthorizationAppleIDButton.ButtonType?
	var delegate: SignInWithAppleRequestDelegate?
	
	init(delegateVC: SignInWithAppleRequestDelegate, appleButtonType: ASAuthorizationAppleIDButton.ButtonType, buttonStackView: UIStackView) {
		super.init()
		
		buttonType = appleButtonType
		delegate = delegateVC
		setUpSignInAppleButton(in: buttonStackView)
	}
	
	// MARK: IBActions
	
	
	// MARK: Helpers
	
	func setUpSignInAppleButton(in buttonStackView: UIStackView) {
		guard let buttonType = buttonType else { return }
		let authorizationButton = ASAuthorizationAppleIDButton(authorizationButtonType: buttonType, authorizationButtonStyle: .black)
		
		authorizationButton.addTarget(self, action: #selector(appleIDWrapper), for: .touchUpInside)
		authorizationButton.cornerRadius = 10
		
		let newIndex = buttonStackView.arrangedSubviews.endIndex
		buttonStackView.insertArrangedSubview(authorizationButton, at: newIndex)
	}
	
	func handleAppleIdRequest(userHasLoggedIn: Bool) {
		var request = [ASAuthorizationRequest]()
		let authorizationAppleIDRequest = ASAuthorizationAppleIDProvider().createRequest()
		
		authorizationAppleIDRequest.requestedScopes = [.fullName, .email]
		request.append(authorizationAppleIDRequest)

		if userHasLoggedIn {
			let authorizationPasswordRequest = ASAuthorizationPasswordProvider().createRequest()
			request.append(authorizationPasswordRequest)
		}
		
		let authorizationController = ASAuthorizationController(authorizationRequests: request)
		authorizationController.delegate = self
		authorizationController.presentationContextProvider = self
		authorizationController.performRequests()
	}
	
	@objc func appleIDWrapper() {
		handleAppleIdRequest(userHasLoggedIn: false)
	}
	
	private func register(appleIDCredential: ASAuthorizationAppleIDCredential) {
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
					self.settingsController.persistcredentials(appleId: userIdentifier, email: nil, password: nil)
					
					UserAPIController.shared.registerNewUser(name: fullName, email: email, password: "123456", appleId: userIdentifier) { (result) in
						switch result {
						case .success(let user):
						self.settingsController.persistcredentials(appleId: userIdentifier, email: nil, password: nil)
							self.settingsController.loginProcedure(user)
							DispatchQueue.main.async {
								self.segueToProfileVC()
							}
						case .failure(let error):
							print("Error registering user: \(error)")
						}
					}
				} else {
					print("Error, user has previously signed in with apple")
//					self.handleAppleIdRequest(userHasLoggedIn: true)
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
	
	private func login(passwordCredential: ASPasswordCredential) {
		let userIdentifier = passwordCredential.user
		let password = passwordCredential.password
		
		let appleIDProvider = ASAuthorizationAppleIDProvider()
		appleIDProvider.getCredentialState(forUserID: userIdentifier) { (credentialState, error) in
			switch credentialState {
			case .authorized:
				
				UserAPIController.shared.login(appleId: userIdentifier, password: "") { (result) in
					switch result {
					case .success(let user):
						self.settingsController.persistcredentials(appleId: userIdentifier, email: nil, password: nil)
						self.settingsController.loginProcedure(user)
						DispatchQueue.main.async {
							self.segueToProfileVC()
						}
					case .failure(let error):
						print(error)
					}
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
			register(appleIDCredential: appleIDCredential)
		case let passwordCredential as ASPasswordCredential:
			login(passwordCredential: passwordCredential)
		default: break
		}
	}
	
	func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
		print("Apple sign-in went wrong: \(error.localizedDescription)")
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

