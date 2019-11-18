//
//  ExploreViewController.swift
//  BestPlaceToLive
//
//  Created by Bradley Yin on 11/11/19.
//  Copyright © 2019 bradleyyin. All rights reserved.
//

import UIKit

class ExploreViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var searchBarButton: UIButton!
    @IBOutlet weak var mostPopularButton: UIButton!
    @IBOutlet weak var topButton: UIButton!
    @IBOutlet weak var bestButton: UIButton!
    @IBOutlet weak var explreLabel: UILabel!
    @IBOutlet weak var popularCitiesLabel: UILabel!
    @IBOutlet weak var exoloreCollectionView: UICollectionView!
    @IBOutlet weak var popularCollectionView: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupButton()

        // Do any additional setup after loading the view.
    }
    private func setupButton() {
        searchBarButton.backgroundColor = .white
        searchBarButton.layer.cornerRadius = 5
        searchBarButton.layer.shadowColor = UIColor.black.cgColor
        searchBarButton.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        searchBarButton.layer.shadowOpacity = 0.4
        searchBarButton.layer.shadowRadius = 5
        searchBarButton.layer.masksToBounds = false
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
