//
//  SearchTableViewController.swift
//  BestPlaceToLive
//
//  Created by Luqmaan Khan on 11/11/19.
//  Copyright © 2019 bradleyyin. All rights reserved.
//

import UIKit

class SearchTableViewController: UITableViewController, SelectedFiltersDelegate {
    //MARK: - Outlets
    @IBOutlet var searchTitle: UILabel!
    @IBOutlet var searchCityBar: UISearchBar!
    @IBOutlet var setPreferencesButton: UIButton!
    var cities: [CityBreakdown]? = []
    var filteredCities: [FilteredCity]? 
    var selectedFilters: [Breakdown]?
    var delegate: SelectedFiltersDelegate?
    
    
    override func viewDidLoad() {
        setupUI()
    }
    
    func userEnteredFilters(filters: [Breakdown]) {
        print("\(filters)")
        CityAPIController.shared.getFilteredCities(filters: filters ) { result in
                switch result {
                case .failure(let error):
                    NSLog("Failed to return cities with filters: \(error)")
                    break
                case .success(let cities):
                    self.cities = nil
                    self.filteredCities = cities
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                }
            }
    }
    
    //MARK: - Actions
    @IBAction func setPreferencesTapped(_ sender: Any) {
        self.selectedFilters = nil
        self.cities = nil
    }
    
    
    // MARK: - Table view data source
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SelectFilters" {
            guard let destVC = segue.destination as? PreferencesViewController else {return}
            destVC.filtersDelegate = self
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let filteredCities = filteredCities {
            return filteredCities.count
        } else {
            return cities!.count
        }
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CityCell", for: indexPath) as? CityTableViewCell else {return UITableViewCell()}
        cell.cardView.layer.cornerRadius = 10
        
        if let filteredCities = filteredCities {
            let filteredCity = filteredCities[indexPath.row]
            cell.cityLabel.text = filteredCity.name
            return cell
        } else {
            let city = cities?[indexPath.row]
            cell.cityLabel.text = city?.fullName
            return cell
        }
    }
    
    
    private func showAlertForInvalidSearchQuery() {
        let alert = UIAlertController(title: "Please Try Again", message: "Your search criteria is invalid", preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .cancel , handler: nil)
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
    
    private func setupUI() {
        setPreferencesButton.backgroundColor = .white
        setPreferencesButton.layer.cornerRadius = 10.0
        setPreferencesButton.layer.borderWidth = 2
        setPreferencesButton.layer.shadowRadius = 5
        setPreferencesButton.layer.shadowOffset = CGSize(width: 5, height: 5)
        setPreferencesButton.layer.shadowColor = UIColor.black.cgColor
        setPreferencesButton.layer.shadowOpacity = 1.0
    }
    
}

extension SearchTableViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let activityView = UIActivityIndicatorView(style: .large)
        activityView.center = self.view.center
        self.view.addSubview(activityView)
        activityView.startAnimating()
        guard let searchText = searchBar.text else {return}
        self.searchTitle.text = "Waiting for \(searchText)"
        CityAPIController.shared.getCitiesBreakdown(relatedTo: searchText) { result in
            switch result {
            case .failure(let error):
                DispatchQueue.main.async {
                    activityView.stopAnimating()
                    self.searchTitle.text = "Find Your Ideal City"
                    self.showAlertForInvalidSearchQuery()
                }
            case .success(let city):
                self.cities = nil
                self.cities = (city)
                DispatchQueue.main.async {
                    activityView.stopAnimating()
                    self.searchTitle.text = "Find Your Ideal City"
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    
}
