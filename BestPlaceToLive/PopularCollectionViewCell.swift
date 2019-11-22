//
//  PopularCollectionViewCell.swift
//  BestPlaceToLive
//
//  Created by Bradley Yin on 11/14/19.
//  Copyright © 2019 bradleyyin. All rights reserved.
//

import UIKit

class PopularCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var imageViewHeightConstraint: NSLayoutConstraint!
    var collectionViewHeight: CGFloat = 0.0 {
        didSet {
            adjustImageViewHeight()
        }
    }
    private func adjustImageViewHeight() {
        imageViewHeightConstraint.constant = collectionViewHeight
    }
    
}
