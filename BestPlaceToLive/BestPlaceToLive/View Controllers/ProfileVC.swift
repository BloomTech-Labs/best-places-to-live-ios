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
	@IBOutlet weak var tableView: UITableView!
	
	// MARK: Properties
	
	private let settingsController = SettingsController.shared
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
		
		tableView.dataSource = self
		tableView.delegate = self
		
		segueToLoginOptionsVC()
		setupViews()
	}
	
	// MARK: IBActions
	
	
	// MARK: Helpers
	
	private func setupViews() {
		guard let user = settingsController.loggedInUser else { return }
		
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

// MARK: TableView DataSource

extension ProfileVC: UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return user?.likes?.count ?? 0
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		guard let city = settingsController.loggedInUser?.likes?[indexPath.row],
			let cell = tableView.dequeueReusableCell(withIdentifier: "CityCell", for: indexPath) as? CityTableViewCell else { return UITableViewCell() }
		
        cellIndexPath = indexPath
        cell.loadImageDelegate = self
		cell.updateViews(cityId: city.id, cityName: city.shortName, stateName: city.state, imageUrl: city.secureUrl)
		
        return cell
	}
}

extension ProfileVC: UITableViewDelegate {
	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
}

//MARK: Load Image Delegate

extension ProfileVC: LoadImageForCellDelegate {
	func loadImage(cell: CityTableViewCell, imageURLString: String, cityId: String) {
        guard let imageURL = URL(string: imageURLString) else {return}
		
		if let cachedImage = cache.value(for: cityId){
			cell.cityImageView.image = cachedImage
		}
		let fetchOp = FetchCityImageOperation(imageURL: imageURL)
		let cacheOp = BlockOperation {
			if let image = fetchOp.image {
				self.cache.cache(value: image, for: cityId)
				DispatchQueue.main.async {
					cell.cityImageView.image = image
				}
			}
		}
		
		let completionOp = BlockOperation {
			defer {self.operations.removeValue(forKey: cityId)}
			if let currentIndexPath = self.tableView.indexPath(for: cell), currentIndexPath != self.cellIndexPath {
				return
			}
		}
		
		
		cacheOp.addDependency(fetchOp)
		completionOp.addDependency(fetchOp)
		photoFetcheQueue.addOperation(fetchOp)
		photoFetcheQueue.addOperation(cacheOp)
		OperationQueue.main.addOperation(completionOp)
		operations[cityId] = fetchOp
		
	}
}
