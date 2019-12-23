//
//  SearchTableViewController.swift
//  BestPlaceToLive
//
//  Created by Luqmaan Khan on 11/11/19.
//  Copyright © 2019 bradleyyin. All rights reserved.
//

import UIKit

class SearchTableViewController: UITableViewController {
	
	// MARK: IBOutlets
	
    @IBOutlet var searchTitle: UILabel!
    @IBOutlet var searchCityBar: UISearchBar!
    @IBOutlet var setPreferencesButton: UIButton!
    var searchedCities: [CityBreakdown]?
    var filteredCities: [FilteredCity]? 
    var selectedFilters: [Breakdown]?
    var delegate: SelectedFiltersDelegate?
    var cache = Cache<String, UIImage>()
    let photoFetcheQueue = OperationQueue()
    var operations = [String: Operation]()
    var indexPath = IndexPath()
    
    
    override func viewDidLoad() {
        navigationController?.isNavigationBarHidden = false
		tableView.keyboardDismissMode = .onDrag
		
		setupUI()
    }
	
	// MARK: IBActions
	
    @IBAction func setPreferencesTapped(_ sender: Any) {
        self.searchCityBar.text = ""
        self.selectedFilters = nil
        self.searchedCities = nil
    }
	
	// MARK: Helpers
    
    private func showAlertForInvalidSearchQuery() {
        let alert = UIAlertController(title: "Please Try Again", message: "Your search criteria is invalid", preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .cancel , handler: nil)
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
    
    private func setupUI() {
        setPreferencesButton.layer.cornerRadius = 10.0
        setPreferencesButton.layer.shadowRadius = 3
        setPreferencesButton.layer.shadowOffset = CGSize(width: 1, height: 1)
        setPreferencesButton.layer.shadowColor = UIColor.black.cgColor
        setPreferencesButton.layer.shadowOpacity = 1.0
		
		EmptyMessage(message: "Search a city in the search bar above or generate cities based on your preferences.", viewController: self)
    }
    
    private func EmptyMessage(message:String, viewController:UITableViewController) {
		let rect = CGRect(origin: CGPoint(x: 0,y :0), size: CGSize(width: self.view.bounds.size.width / 1.1, height: self.view.bounds.size.height))
        let messageLabel = UILabel(frame: rect)
		
        messageLabel.text = message
        messageLabel.textColor = UIColor.black
        messageLabel.numberOfLines = 0;
        messageLabel.textAlignment = .center;
        messageLabel.font = UIFont(name: "TrebuchetMS", size: 15)
        messageLabel.sizeToFit()
        
        viewController.tableView.backgroundView = messageLabel;
        viewController.tableView.separatorStyle = .none;
    }
    
    // MARK: - Table view data source
	
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SelectFilters" {
            guard let destVC = segue.destination as? PreferencesViewController else {return}
            destVC.filtersDelegate = self
        }
        if segue.identifier == "ShowCity" {
            guard let cityDetailsVC = segue.destination as? CityDetailsViewController, let indexPath = tableView.indexPathForSelectedRow else {return}
            let filteredCity = filteredCities?[indexPath.row]
            let city = searchedCities?[indexPath.row]
            cityDetailsVC.filteredCity = filteredCity
            cityDetailsVC.city = city
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let filteredCities = filteredCities {
            return filteredCities.count
        } else if let searchedCities = searchedCities {
            return searchedCities.count
        }
        return 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CityCell", for: indexPath) as? CityTableViewCell else {return UITableViewCell()}
        self.indexPath = indexPath
        cell.loadImageDelegate = self
		if let city = filteredCities?[indexPath.row] {
			cell.updateViews(cityId: city.id, cityName: city.shortName, stateName: city.state, imageUrl: city.secureUrl)
        } else if let city = searchedCities?[indexPath.row] {
			cell.updateViews(cityId: city.id, cityName: city.shortName, stateName: city.state, imageUrl: city.secureUrl)
            return cell
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
}

// MARK: - Load Image Cell

extension SearchTableViewController: LoadImageForCellDelegate {
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
			if let currentIndexPath = self.tableView.indexPath(for: cell), currentIndexPath != self.indexPath {
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

// MARK: - Apply Selected Filters

extension SearchTableViewController: SelectedFiltersDelegate {
    func userEnteredFilters(filters: [Breakdown]) {
        CityAPIController.shared.getFilteredCities(filters: filters ) { result in
            switch result {
            case .failure(let error):
                NSLog("Failed to return cities with filters: \(error)")
                break
            case .success(let cities):
                self.searchedCities = nil
                self.filteredCities = cities
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
    }
}

// MARK: - SearchBar Delegate

extension SearchTableViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
		guard let searchText = searchBar.text, searchText != "" else {return}
		
		view.endEditing(true)
        filteredCities = nil
		
        let activityView = UIActivityIndicatorView(style: .large)
        activityView.center = self.view.center
        view.addSubview(activityView)
        activityView.startAnimating()
		
        self.searchTitle.text = "Waiting for \(searchText)"
        CityAPIController.shared.searchforCities(relatedTo: searchText) { result in
            switch result {
			case .failure(_):
                DispatchQueue.main.async {
                    activityView.stopAnimating()
                    self.searchTitle.text = "Explore"
                    self.showAlertForInvalidSearchQuery()
                }
            case .success(let city):
                self.searchedCities = nil
                self.searchedCities = (city)
                DispatchQueue.main.async {
                    activityView.stopAnimating()
                    self.searchTitle.text = "Explore"
                    self.tableView.reloadData()
                }
            }
        }
    }
}
