//
//  SearchTableViewController.swift
//  BestPlaceToLive
//
//  Created by Luqmaan Khan on 11/11/19.
//  Copyright © 2019 bradleyyin. All rights reserved.
//

import UIKit

class SearchTableViewController: UITableViewController {

    @IBOutlet var searchTitle: UILabel!
    //MARK: - Outlets
    
    @IBOutlet var searchCityBar: UISearchBar!
    @IBOutlet var setPreferencesButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    //MARK: - Actions
    @IBAction func setPreferencesTapped(_ sender: Any) {
    }
    

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
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
        setPreferencesButton.backgroundColor = .lightGray
        setPreferencesButton.layer.cornerRadius = 10.0
        
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
