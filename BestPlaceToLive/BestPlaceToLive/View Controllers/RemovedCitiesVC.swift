//
//  RemovedCitiesVC.swift
//  BestPlaceToLive
//
//  Created by Jeffrey Santana on 12/18/19.
//  Copyright © 2019 bradleyyin. All rights reserved.
//

import UIKit

class RemovedCitiesVC: UITableViewController {

	// MARK: IBOutlets
	
	
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
		
		
	}
	
	// MARK: IBActions
	
	
	// MARK: Helpers
	
	
	// MARK: TableView DataSource & Delegate
	
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return user?.dislikes?.count ?? 0
	}
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		guard let city = user?.dislikes?[indexPath.row],
			let cell = tableView.dequeueReusableCell(withIdentifier: "CityCell", for: indexPath) as? CityTableViewCell else { return UITableViewCell() }
		
        cellIndexPath = indexPath
        cell.loadImageDelegate = self
		cell.updateViews(cityId: city.id, cityName: city.shortName, stateName: city.state, imageUrl: city.secureUrl)
		
        return cell
	}
	
	override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
		let delete = UIContextualAction(style: .destructive, title: "Undo") { (action, view, handler) in
			guard let cityId = self.user?.dislikes?[indexPath.row].id else { return }
			UserAPIController.shared.removeDislikedCity(id: cityId) { (result) in
				switch result {
				case .success(let likesAndFactors):
					SettingsController.shared.updateUser(email: nil, location: nil, likesAndFactors: likesAndFactors)
					DispatchQueue.main.async {
						tableView.deleteRows(at: [indexPath], with: .automatic)
					}
				case .failure(_):
					print("Removing disliked city failed")
				}
			}
			handler(true)
		}
		
		return UISwipeActionsConfiguration(actions: [delete])
	}
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
}

//MARK: Load Image Delegate

extension RemovedCitiesVC: LoadImageForCellDelegate {
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
