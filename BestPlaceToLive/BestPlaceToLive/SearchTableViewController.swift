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
    var topTenCities: [CityBreakdown] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
		CityAPIController.shared.getTopTenBreakdown { cities in
            do {
                let returnedCities = try cities.get()
                self.topTenCities = returnedCities
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
        return topTenCities.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CityCell", for: indexPath) as? CityTableViewCell else {return UITableViewCell()}
        cell.cardView.layer.cornerRadius = 10
        let city = topTenCities[indexPath.row]
        cell.cityLabel.text = city.fullName
        cell.stateZipLabel.text = city.state
        return cell
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    }
    
    private func showActivityIndicatory() {
        let activityView = UIActivityIndicatorView(style: .large)
        activityView.center = self.view.center
        self.view.addSubview(activityView)
        activityView.startAnimating()
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
        //dismiss keyboard as soon as enter clicked
        showActivityIndicatory()
        guard let searchText = searchBar.text else {return}
        self.searchTitle.text = "Waiting for \(searchText)"
        //use if statement to check for improper strings, and check if the search parameter returns the right result. e.g if its a town, show a alert view ""typed word" is not a valid search query, please search using a city name.
    }
    
    
}
