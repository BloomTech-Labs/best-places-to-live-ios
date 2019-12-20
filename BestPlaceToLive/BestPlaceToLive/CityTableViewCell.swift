//
//  CityTableViewCell.swift
//  BestPlaceToLive
//
//  Created by Luqmaan Khan on 11/11/19.
//  Copyright © 2019 bradleyyin. All rights reserved.
//

import UIKit

protocol LoadImageForCellDelegate {
    func loadImage(cell: CityTableViewCell, imageURLString: String, searchedCity: CityBreakdown?, filteredCity: FilteredCity?)
}

class CityTableViewCell: UITableViewCell {
    
    @IBOutlet var heartImageView: UIImageView!
    
    @IBOutlet var cityLabel: UILabel!
    @IBOutlet var cityImageView: UIImageView!
    
    var loadImageDelegate: LoadImageForCellDelegate?
    
    var filteredCity: FilteredCity? {
        didSet {
            updateViews()
        }
    }
    
    var searchedCity: CityBreakdown? {
        didSet {
            updateViews()
        }
    }
    
    func clearCity() {
        cityImageView.image = nil
        self.filteredCity = nil
        self.searchedCity = nil
    }
    
    func updateViews() {
        let cellContentView = self.contentView.bounds
        cityImageView.layer.cornerRadius = 20
        cityImageView.bounds = cellContentView
        cityImageView.contentMode = .scaleAspectFill
        imageView?.center = self.contentView.center
        imageView?.clipsToBounds = true
        cityLabel.layer.shadowRadius = 5
        cityLabel.layer.shadowOffset = CGSize(width: 5, height: 5)
        cityLabel.layer.shadowColor = UIColor.black.cgColor
        cityLabel.layer.shadowOpacity = 1.0
        
        if let filteredCity = filteredCity, searchedCity == nil {
            
            cityLabel.text = "\(filteredCity.name)".capitalized
            loadImageDelegate?.loadImage(cell: self, imageURLString: filteredCity.secureUrl!, searchedCity: nil, filteredCity: filteredCity)
        } else {
            guard let city = searchedCity, let cityName = city.shortName, let state = city.state else {return}
            cityLabel.text = "\(cityName), \(state)".capitalized
            loadImageDelegate?.loadImage(cell: self, imageURLString: (city.secureURL)!, searchedCity: city, filteredCity: nil)
        }
        
    }
    
}
