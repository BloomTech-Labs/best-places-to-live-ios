//
//  AppDelegate.swift
//  BestPlaceToLive
//
//  Created by Bradley Yin on 11/8/19.
//  Copyright © 2019 bradleyyin. All rights reserved.
//

import UIKit
import AuthenticationServices

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
		let settingsController = SettingsController.shared
		
		if let userIdentifier = settingsController.appleId {
			let appleIDProvider = ASAuthorizationAppleIDProvider()
			
			appleIDProvider.getCredentialState(forUserID: userIdentifier) { (credentialState, error) in
				switch credentialState {
				case .authorized:
					
					UserAPIController.shared.login(appleId: userIdentifier, password: "123456") { (result) in
						switch result {
						case .success(let user):
							SettingsController.shared.loginProcedure(user)
						case .failure(let error):
							print(error)
						}
					}
					break
				case .revoked,
					 .notFound:
					SettingsController.shared.logoutProcedure {
						
					}
					break
				default:
					break
				}
			}
		} else if let credentials = settingsController.userCredentials {
			UserAPIController.shared.login(email: credentials.email, password: credentials.password) { (result) in
				switch result {
				case .success(let user):
					SettingsController.shared.loginProcedure(user)
				case .failure(let error):
					print(error)
				}
			}
		}
		
		return true
	}

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

