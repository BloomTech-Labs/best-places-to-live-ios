//
//  SettingsController.swift
//  BestPlaceToLive
//
//  Created by Jeffrey Santana on 11/12/19.
//  Copyright © 2019 bradleyyin. All rights reserved.
//

import UIKit
import KeychainAccess

class SettingsController {
	static let shared = SettingsController()
	
	private let defaults = UserDefaults.standard
	private let keychain = Keychain(service: "com.lambda.BestPlaceToLive")
	
	private let tokenKey = "token_key"
	private let appleIdKey = "appleId_key"
	private let emailKey = "username_key"
	private let userPasswordKey = "user_password_key"
	private let userImgKey = "user_img_key"
	private let saveProfileKey = "save_profile_key"
	private let freshInstallationKey = "fresh_installation_key"
	
	private(set) var userToken: String? {
		get {
			return keychain[tokenKey]
		}
		set {
			guard let newToken = newValue else {
				keychain[tokenKey] = nil
				return
			}
			keychain[tokenKey] = newToken
		}
	}
	
	private(set) var loggedInUser: UserInfo?
	
//	var userProfileImg: UIImage? {
//		get {
//			if let dir = try? FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false) {
//				return UIImage(contentsOfFile: URL(fileURLWithPath: dir.absoluteString).appendingPathComponent("profilePic.png").path)
//			}
//			print("No profile image data found.")
//			return UIImage(named: "Profile_Pic")
//		}
//		set {
//			if let newImage = newValue, let data = newImage.jpegData(compressionQuality: 1) ?? newImage.pngData() {
//				if let directory = try? FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false) as NSURL {
//					do {
//						try data.write(to: directory.appendingPathComponent("profilePic.png")!)
//					} catch {
//						print(error.localizedDescription)
//					}
//				}
//			}
//
//		}
//	}
	
	private(set) var appleId: String? {
		get {
			return keychain[appleIdKey]
		}
		set {
			guard let newAppleId = newValue else {
				keychain[appleIdKey] = nil
				return
			}
			keychain[appleIdKey] = newAppleId
		}
	}
	
	private(set) var userCredentials: LoginRequest? {
		get {
			guard let email = keychain[emailKey], let password = keychain[userPasswordKey] else { return nil }
			return LoginRequest(email: email, password: password)
		}
		set {
			guard let newValue = newValue else {
				keychain[emailKey] = nil
				keychain[userPasswordKey] = nil
				return
			}
			keychain[emailKey] = newValue.email
			keychain[userPasswordKey] = newValue.password
		}
	}
	
	var isFreshInstall: Bool {
		get {
			guard let isFresh = defaults.value(forKey: freshInstallationKey) as? Bool else {
				try? keychain.removeAll()
				defaults.set(true, forKey: freshInstallationKey)
				return false
			}
			return isFresh
		}
		set {
			if !newValue {
				userCredentials = nil
			}
			defaults.set(newValue, forKey: freshInstallationKey)
		}
	}
	
	var isSaveCredentials: Bool {
		get {
			guard let isSaved = defaults.value(forKey: saveProfileKey) as? Bool else { return false }
			return isSaved
		}
		set {
			if !newValue {
				userCredentials = nil
			}
			defaults.set(newValue, forKey: saveProfileKey)
		}
	}
	
	func updateUser(email: String?, location: String?, likesAndFactors: LikesAndFactors?) {
		if let email = email {
			loggedInUser?.email = email
		}
		if let location = location {
			loggedInUser?.location = location
		}
		if let likesAndFactors = likesAndFactors {
			loggedInUser?.likes = likesAndFactors.likes
			loggedInUser?.dislikes = likesAndFactors.dislikes
			loggedInUser?.factors = likesAndFactors.factors
		}
	}
	
	func updateCredentials(email: String?, password: String?) {
		if let email = email {
			userCredentials?.email = email
		}
		if let password = password {
			userCredentials?.password = password
		}
	}
	
	func persistcredentials(appleId: String?, email: String?, password: String?) {
		if let appleId = appleId {
			self.appleId = appleId
		}
		if let email = email, let password = password, isSaveCredentials {
			userCredentials = LoginRequest(email: email, password: password)
		}
	}
	
	func loginProcedure(_ user: UserInfo) {
		loggedInUser = user
		userToken = user.token
	}
	
	func logoutProcedure(completion: @escaping () -> Void) {
		loggedInUser = nil
		userToken = nil
		isSaveCredentials = false
		print("USER LOGGED OUT")
		completion()
	}
}
