//
//  ProfileVC.swift
//  BestPlaceToLive
//
//  Created by Jeffrey Santana on 11/15/19.
//  Copyright © 2019 bradleyyin. All rights reserved.
//

import UIKit

class ProfileVC: UIViewController {

	// MARK: IBOutlets
	
	@IBOutlet weak var nameLabel: UILabel!
	@IBOutlet weak var emailLabel: UILabel!
	@IBOutlet weak var locationLabel: UILabel!
	
	// MARK: Properties
	
	let settingsController = SettingsController.shared
	
	// MARK: Life Cycle
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		setupViews()
	}
	
	override func viewWillAppear(_ animated: Bool) {
		segueToLoginOptionsVC()
	}
	
	// MARK: IBActions
	
	@IBAction func changeEmailBtnTapped(_ sender: Any) {
		
	}
	
	@IBAction func changeLocationBtnTapped(_ sender: Any) {
		
	}
	
	@IBAction func changePasswordBtnTapped(_ sender: Any) {
		
	}
	
	@IBAction func logoutBtnTapped(_ sender: Any) {
		settingsController.logoutProcedure()
		
		let storyboard = UIStoryboard(name: "Login", bundle: nil)
		
		if let initialVC = storyboard.instantiateInitialViewController() as? UINavigationController {
				guard let optionsVC = initialVC.viewControllers.first as? LoginVC else { return }
			
			navigationController?.viewControllers = [optionsVC]
		}
	}
	
	@IBAction func deleteAccountBtnTapped(_ sender: Any) {
		
	}
	
	// MARK: Helpers
	
	private func setupViews() {
		let user = SettingsController.shared.loggedInUser
		
		nameLabel.text = user?.name
		emailLabel.text = user?.email
		locationLabel.text = user?.location
	}
	
	private func segueToLoginOptionsVC() {
		if SettingsController.shared.loggedInUser == nil {
			let storyboard = UIStoryboard(name: "Login", bundle: nil)
			
			if let initialVC = storyboard.instantiateInitialViewController() as? UINavigationController {
					guard let loginVC = initialVC.viewControllers.first as? LoginVC else { return }
				
				navigationController?.viewControllers = [loginVC]
			}
		}
	}
}
