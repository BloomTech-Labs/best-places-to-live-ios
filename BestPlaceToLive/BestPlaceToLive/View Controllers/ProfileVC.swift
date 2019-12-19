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
}

//MARK: - Edit Profile Button

extension ProfileVC: EditProfileButtonDelegate {
	func viewTapped(for buttonType: ProfileButton) {
		switch buttonType {
		case .cities:
			performSegue(withIdentifier: "RemovedCitiesVCSegue", sender: nil)
		case .email:
			performSegue(withIdentifier: "RemovedCitiesVCSegue", sender: nil)
		case .location:
			performSegue(withIdentifier: "RemovedCitiesVCSegue", sender: nil)
		case .password:
			performSegue(withIdentifier: "RemovedCitiesVCSegue", sender: nil)
		}
	}
}
