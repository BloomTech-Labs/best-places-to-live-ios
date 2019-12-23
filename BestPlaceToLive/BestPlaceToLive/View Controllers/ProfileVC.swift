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
	
	@IBOutlet weak var userImageView: UIImageView!
	@IBOutlet weak var nameLabel: UILabel!
	@IBOutlet weak var locationLabel: UILabel!
	@IBOutlet weak var editEmailBtn: EditProfileButton!
	@IBOutlet weak var changePasswordBtn: EditProfileButton!
	@IBOutlet weak var switchLocationBtn: EditProfileButton!
	@IBOutlet weak var removedCitiesBtn: EditProfileButton!
	
	// MARK: Properties
	
	private var user: UserInfo? {
		SettingsController.shared.loggedInUser
	}
	private var cellIndexPath: IndexPath?
    private var cache = Cache<String, UIImage>()
    private var operations = [String: Operation]()
    private let photoFetcheQueue = OperationQueue()
	
	// MARK: Life Cycle
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		segueToLoginOptionsVC()
		setupViews()
	}
	
	// MARK: IBActions
	
	
	// MARK: Helpers
	
	private func setupViews() {
		guard let user = user else { return }
		
		editEmailBtn.passInInfo(delegate: self, button: .email)
		changePasswordBtn.passInInfo(delegate: self, button: .password)
		switchLocationBtn.passInInfo(delegate: self, button: .location)
		removedCitiesBtn.passInInfo(delegate: self, button: .cities)
		
		nameLabel.text = user.name
		locationLabel.text = user.location
		
		userImageView.layer.cornerRadius = userImageView.frame.width / 2
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
	
	private func updateProfile(newEmail: String?, newPassword: String?, newLocation: String?) {
		UserAPIController.shared.updateProfile(name: nil, email: newEmail, password: newPassword) { (result) in
			switch result {
			case .success(_): SettingsController.shared.updateUser(email: newEmail, location: newLocation, likesAndFactors: nil)
			case .failure(_):
				print("Profile update failed")
			}
		}
	}
	
	private func updateEmail() {
		let alert = UIAlertController(title: "Update Email", message: nil, preferredStyle: .alert)

		alert.addTextField { (textField) in
			textField.placeholder = "New email"
		}
		alert.addTextField { (textField) in
			textField.placeholder = "Password"
			textField.isSecureTextEntry = true
		}

		alert.addAction(UIAlertAction(title: "Save", style: .default, handler: { (_) in
			guard let newEmail = alert.textFields![0].optionalText else { return }
			self.updateProfile(newEmail: newEmail, newPassword: nil, newLocation: nil)
		}))

		alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))

		self.present(alert, animated:true, completion: nil)
	}
	
	private func updatePassword() {
		let alert = UIAlertController(title: "Update Password", message: nil, preferredStyle: .alert)
		
		alert.addTextField { (textField) in
			textField.placeholder = "Old password"
		}
		alert.addTextField { (textField) in
			textField.placeholder = "New password"
		}
		alert.addTextField { (textField) in
			textField.placeholder = "Verify password"
		}
		alert.textFields?.forEach({$0.isSecureTextEntry = true})

		alert.addAction(UIAlertAction(title: "Save", style: .default, handler: { (_) in
			guard let oldPass = alert.textFields![0].optionalText,
				let newPass = alert.textFields![1].optionalText, let verPass = alert.textFields![2].optionalText,
				oldPass == SettingsController.shared.userCredentials?.password && newPass == verPass
				else { return }
			self.updateProfile(newEmail: nil, newPassword: newPass, newLocation: nil)
		}))

		alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))

		self.present(alert, animated:true, completion: nil)
	}
}

//MARK: - Edit Profile Button

extension ProfileVC: EditProfileButtonDelegate {
	func viewTapped(for buttonType: ProfileButton) {
		switch buttonType {
		case .cities:
			performSegue(withIdentifier: "RemovedCitiesVCSegue", sender: nil)
		case .email:
			updateEmail()
		case .location:
			break
		case .password:
			updatePassword()
		}
	}
}
