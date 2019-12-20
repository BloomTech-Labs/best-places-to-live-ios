//
//  SettingsVC.swift
//  BestPlaceToLive
//
//  Created by Jeffrey Santana on 12/13/19.
//  Copyright © 2019 bradleyyin. All rights reserved.
//

import UIKit

class SettingsVC: UIViewController {

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
	
	// MARK: IBActions
	
	@IBAction func changeEmailBtnTapped(_ sender: Any) {
		
	}
	
	@IBAction func changeLocationBtnTapped(_ sender: Any) {
		
	}
	
	@IBAction func changePasswordBtnTapped(_ sender: Any) {
		
	}
	
	@IBAction func logoutBtnTapped(_ sender: Any) {
		settingsController.logoutProcedure {
			self.segueToLoginOptionsVC()
		}
	}
	
	@IBAction func deleteAccountBtnTapped(_ sender: Any) {
		
	}
	
	// MARK: Helpers
	
	private func setupViews() {
		guard let user = SettingsController.shared.loggedInUser else { return }
		
		nameLabel.text = user.name
		emailLabel.text = user.email
		locationLabel.text = user.location
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
