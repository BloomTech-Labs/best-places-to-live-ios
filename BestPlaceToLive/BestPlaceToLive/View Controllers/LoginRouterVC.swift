//
//  LoginRouterVC.swift
//  BestPlaceToLive
//
//  Created by Jeffrey Santana on 11/15/19.
//  Copyright © 2019 bradleyyin. All rights reserved.
//

import UIKit

class LoginRouterVC: UINavigationController {

	// MARK: IBOutlets
	
	
	// MARK: Properties
	
	
	// MARK: Life Cycle
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		
		if SettingsController.shared.loggedInUser != nil {
			setRootVC(from: "Profile")
		} else {
			setRootVC(from: "Login")
		}
	}
	
	// MARK: IBActions
	
	
	// MARK: Helpers
	
	private func setRootVC(from storyboardName: String) {
		let storyboard = UIStoryboard(name: storyboardName, bundle: nil)
		
		if let initialVC = storyboard.instantiateInitialViewController() as? UINavigationController,
			let optionsVC = initialVC.viewControllers.first as? LoginOptionsVC {
			viewControllers = [optionsVC]
			print("\(storyboardName)'s initial VC set")
		}
	}
}
