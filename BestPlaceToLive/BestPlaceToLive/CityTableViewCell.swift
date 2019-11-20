//
//  CityTableViewCell.swift
//  BestPlaceToLive
//
//  Created by Luqmaan Khan on 11/11/19.
//  Copyright © 2019 bradleyyin. All rights reserved.
//

import UIKit

class CityTableViewCell: UITableViewCell {

   
    @IBOutlet var cardView: UIView!
    @IBOutlet var cityLabel: UILabel!
    @IBOutlet var stateZipLabel: UILabel!
    @IBOutlet var cityImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
