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
    
    let apiController = CityAPIController()
    var topTenCities: [CityBreakdown] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupButton()
        loadTopTen()
        setupViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
         self.navigationController?.isNavigationBarHidden = true
    }
    
    private func setupViews() {
        popularCollectionView.delegate = self
        popularCollectionView.dataSource = self
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
    
    
    private func loadTopTen() {
        apiController.getTopTenBreakdown { (result) in
            switch result {
            case .success:
                do {
                    self.topTenCities = try result.get()
                    DispatchQueue.main.async {
                        self.popularCollectionView.reloadData()
                        print("reload")
                    }
                    
                } catch {
                    fatalError("cannot load top 10")
                }
                
            default:
                break
            }
        }
    }
    
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "TopTenToDetailSegue" {
            guard let detailVC = segue.destination as? CityDetailsViewController, let indexPath = popularCollectionView.indexPathsForSelectedItems?.first else { return }
            detailVC.city = topTenCities[indexPath.item]
            
        }
    }
    

}
extension ExploreViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.popularCollectionView {
            return topTenCities.count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.popularCollectionView {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TopTenCell", for: indexPath) as? PopularCollectionViewCell else { fatalError("cannot make TopTenCell") }
            let city = topTenCities[indexPath.item]
            cell.cityNameLabel.text = city.name
            let imageURL = URL(string: city.secureURL!)!
            print(imageURL)
            if let imageData = try? Data(contentsOf: imageURL) {
                cell.imageView.image = UIImage(data: imageData)
            }
            
            
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: popularCollectionView.bounds.height)
    }
    
    
}
