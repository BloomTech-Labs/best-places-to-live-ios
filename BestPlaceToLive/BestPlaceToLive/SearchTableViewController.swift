//
//  SearchTableViewController.swift
//  BestPlaceToLive
//
//  Created by Luqmaan Khan on 11/11/19.
//  Copyright © 2019 bradleyyin. All rights reserved.
//

import UIKit

class SearchTableViewController: UITableViewController {
    
    
    //MARK: - Outlets
    @IBOutlet var searchTitle: UILabel!
    @IBOutlet var searchCityBar: UISearchBar!
    @IBOutlet var setPreferencesButton: UIButton!
    var cities: [CityBreakdown]? = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
		CityAPIController.shared.getTopTenBreakdown { cities in
            do {
                let returnedCities = try cities.get()
                self.cities = returnedCities
            } catch {
                NSLog("Error getting top ten cities")
            }
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    //MARK: - Actions
    @IBAction func setPreferencesTapped(_ sender: Any) {
    }
    
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cities?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CityCell", for: indexPath) as? CityTableViewCell else {return UITableViewCell()}
        cell.cardView.layer.cornerRadius = 10
        let city = cities?[indexPath.row]
        cell.cityLabel.text = city?.fullName
        return cell
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
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
                     self.showAlertForInvalidSearchQuery()
                }
            case .success(let city):
                activityView.stopAnimating()
                self.cities = nil
                self.cities = (city)
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    
}
