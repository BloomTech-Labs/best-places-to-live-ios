//
//  ImageCell.swift
//  BestPlaceToLive
//
//  Created by Luqmaan Khan on 12/12/19.
//  Copyright © 2019 bradleyyin. All rights reserved.
//

import UIKit

class ImageCell: UICollectionViewCell {
    @IBOutlet var imageWidth: NSLayoutConstraint!
    
    @IBOutlet var cityImage: UIImageView!
    
    var image: UIImage! {
        didSet {
            cityImage.image = image
        }
    }
}
