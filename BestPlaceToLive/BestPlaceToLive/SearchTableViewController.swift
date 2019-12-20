//
//  SearchTableViewController.swift
//  BestPlaceToLive
//
//  Created by Luqmaan Khan on 11/11/19.
//  Copyright © 2019 bradleyyin. All rights reserved.
//

import UIKit

class SearchTableViewController: UITableViewController, SelectedFiltersDelegate, LoadImageForCellDelegate {
    //MARK: - Outlets
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
    var likedCities: [CityBreakdown] = []
    override func viewDidLoad() {
        setupUI()
        if self.searchedCities == nil && self.filteredCities == nil {
            EmptyMessage(message: "Search a city in the search bar above or generate cities based on your preferences.", viewController: self)
            
        }
        self.navigationController?.isNavigationBarHidden = false
    }
    
    
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
    
    //MARK: - Actions
    @IBAction func setPreferencesTapped(_ sender: Any) {
        self.searchCityBar.text = ""
        self.selectedFilters = nil
        self.searchedCities = nil
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
        cell.clearCity()
        
        if let filteredCities = filteredCities {
            let filteredCity = filteredCities[indexPath.row]
            if likedCities.contains(where: {"\($0.shortName ?? ""), \($0.state ?? "")" == filteredCity.name}) {
                cell.heartImageView.image = UIImage(named: "heartIcon")
            }
            cell.filteredCity = filteredCity
            return cell
        }
        if let cities = searchedCities {
            let searchedCity = cities[indexPath.row]
            for city in likedCities {
                if let cityName = city.shortName {
                    if cityName == searchedCity.shortName {
                        cell.heartImageView.image = UIImage(named: "heartIcon")
                    }
                }
            }
            
            cell.searchedCity = searchedCity
            return cell
        }
        return UITableViewCell()
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        if self.searchedCities == nil && self.filteredCities == nil {
            EmptyMessage(message: "Search a city in the search bar above or generate cities based on your preferences by tapping the 'Use Filters' Button", viewController: self)
            return 0
        }
        return 1
    }
    func loadImage(cell: CityTableViewCell, imageURLString: String, searchedCity: CityBreakdown?, filteredCity: FilteredCity?) {
        guard let imageURL = URL(string: imageURLString) else {return}
        if searchedCity == nil {
            if let cachedImage = cache.value(for: filteredCity!.id){
                cell.cityImageView.image = cachedImage
            }
            let fetchOp = FetchCityImageOperation(imageURL: imageURL)
            let cacheOp = BlockOperation {
                if let image = fetchOp.image {
                    self.cache.cache(value: image, for: filteredCity!.id)
                    DispatchQueue.main.async {
                        cell.cityImageView.image = image
                    }
                }
            }
            
            let completionOp = BlockOperation {
                defer {self.operations.removeValue(forKey: filteredCity!.id)}
                if let currentIndexPath = self.tableView.indexPath(for: cell), currentIndexPath != self.indexPath {
                    return
                }
            }
            
            
            cacheOp.addDependency(fetchOp)
            completionOp.addDependency(fetchOp)
            photoFetcheQueue.addOperation(fetchOp)
            photoFetcheQueue.addOperation(cacheOp)
            OperationQueue.main.addOperation(completionOp)
            operations[filteredCity!.id] = fetchOp
            
        } else {
            if let cachedImage = cache.value(for: (searchedCity?.id)!) {
                cell.cityImageView.image = cachedImage
            }
            let fetchOp = FetchCityImageOperation(imageURL: imageURL)
            let cacheOp = BlockOperation {
                if let image = fetchOp.image {
                    self.cache.cache(value: image, for: (searchedCity?.id)!)
                    DispatchQueue.main.async {
                        cell.cityImageView.image = image
                    }
                }
            }
            
            let completionOp = BlockOperation {
                defer {self.operations.removeValue(forKey: (searchedCity?.id)!)}
                if let currentIndexPath = self.tableView.indexPath(for: cell), currentIndexPath != self.indexPath {
                    return
                }
            }
            
            
            cacheOp.addDependency(fetchOp)
            completionOp.addDependency(fetchOp)
            photoFetcheQueue.addOperation(fetchOp)
            photoFetcheQueue.addOperation(cacheOp)
            OperationQueue.main.addOperation(completionOp)
            operations[(searchedCity?.id)!] = fetchOp
        }
    }
    
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
        
    }
    
    func EmptyMessage(message:String, viewController:UITableViewController) {
        let rect = CGRect(origin: CGPoint(x: 0,y :0), size: CGSize(width: self.view.bounds.size.width, height: self.view.bounds.size.height))
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
    
}
extension SearchTableViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.filteredCities = nil
        let activityView = UIActivityIndicatorView(style: .large)
        activityView.center = self.view.center
        self.view.addSubview(activityView)
        activityView.startAnimating()
        guard let searchText = searchBar.text else {return}
        self.searchTitle.text = "Waiting for \(searchText)"
        CityAPIController.shared.searchforCities(relatedTo: searchText) { result in
            switch result {
            case .failure(let error):
                DispatchQueue.main.async {
                    activityView.stopAnimating()
                    self.searchTitle.text = "Explore"
                    self.showAlertForInvalidSearchQuery()
                }
            case .success(let city):
                self.searchedCities = nil
                self.searchedCities = (city)
                UserAPIController.shared.getUserInfo { result in
                    switch result {
                    case .failure(let error):
                        NSLog("Error getting user info: \(error)")
                    case .success(let cities):
                        self.likedCities = cities.likes
                        
                    }
                }
                DispatchQueue.main.async {
                    activityView.stopAnimating()
                    self.searchTitle.text = "Explore"
                    self.tableView.reloadData()
                }
            }
        }
    }
}
