//
//  CityTableViewCell.swift
//  BestPlaceToLive
//
//  Created by Luqmaan Khan on 11/11/19.
//  Copyright © 2019 bradleyyin. All rights reserved.
//

import UIKit

protocol LoadImageForCellDelegate {
	func loadImage(cell: CityTableViewCell, imageURLString: String, cityId: String)
}

class CityTableViewCell: UITableViewCell {
   
    @IBOutlet var cityLabel: UILabel!
    @IBOutlet var stateLabel: UILabel!
    @IBOutlet var cityImageView: UIImageView!
    
    var loadImageDelegate: LoadImageForCellDelegate?
	
	override func awakeFromNib() {
        cityImageView.layer.cornerRadius = 20
        cityLabel.layer.shadowRadius = 5
        cityLabel.layer.shadowOffset = CGSize(width: 5, height: 5)
        cityLabel.layer.shadowColor = UIColor.black.cgColor
        cityLabel.layer.shadowOpacity = 1.0
	}
    
	func updateViews(cityId: String?, cityName: String?, stateName: String?, imageUrl: String?) {
        cityImageView.image = nil
		
		guard let cityName = cityName, let stateName = stateName else { return }
		cityLabel.text = cityName.capitalized
		stateLabel.text = stateName.capitalized
		
		guard let id = cityId, let url = imageUrl else { return }
		loadImageDelegate?.loadImage(cell: self, imageURLString: url, cityId: id)
    }

}
