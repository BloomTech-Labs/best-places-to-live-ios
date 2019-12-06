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
    @IBOutlet weak var exploreCollectionView: UICollectionView!
    @IBOutlet weak var popularCollectionView: UICollectionView!
    @IBOutlet weak var liveInLabel: UILabel!
    
    var topTenCities: [CityBreakdown] = []
    var categoryCities: [FilteredCity] = []
    
    var imageDataCache: [String: Data] = [:]
    var workItemCache: [UICollectionViewCell: DispatchWorkItem] = [:]
    
    var category: Breakdown = .scoreSafety
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupButton()
        setupViews()
        DispatchQueue.global().async { [weak self] in
            self?.loadTopTen()
            self?.getCityOnCategory()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
         self.navigationController?.isNavigationBarHidden = true
    }
    
    private func setupViews() {
        popularCollectionView.delegate = self
        popularCollectionView.dataSource = self
        exploreCollectionView.dataSource = self
        exploreCollectionView.delegate = self
        liveInLabel.textColor = .white
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
        CityAPIController.shared.getTopTenBreakdown { (result) in
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
            case .failure(let error):
                fatalError(error.localizedDescription)
            }
        }
    }
    
    private func getCityOnCategory() {
        CityAPIController.shared.getFilteredCities(filters: [category] ) { result in
            switch result {
            case .failure(let error):
                NSLog("Failed to return cities with filters: \(error)")
                break
            case .success(let cities):
                self.categoryCities = cities
                print(cities)
                DispatchQueue.main.async {
                    self.exploreCollectionView.reloadData()
                }
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
        if collectionView == self.exploreCollectionView {
            print(categoryCities.count)
            return categoryCities.count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == self.popularCollectionView {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TopTenCell", for: indexPath) as? PopularCollectionViewCell else { fatalError("cannot make TopTenCell") }
            
            let city = topTenCities[indexPath.item]
            cell.cityNameLabel.text = city.name
            
            let work = DispatchWorkItem { [weak self] in
                if let imageData = self?.imageDataCache[city.name ?? ""] {
                    DispatchQueue.main.async {
                        cell.imageView.image = UIImage(data: imageData)
                    }
                } else {
                    if let imageURL = URL(string: city.secureURL ?? "") {
                        if let imageData = try? Data(contentsOf: imageURL) {
                            DispatchQueue.main.async {
                                cell.collectionViewHeight = collectionView.bounds.height
                                cell.imageView.image = UIImage(data: imageData)
                            }
                        }
                    }
                }
            }
            
            DispatchQueue.global().async { [weak self] in
                if let workItem = self?.workItemCache[cell] {
                    workItem.cancel()
                }
                work.perform()
            }
            return cell
        }
        if collectionView == self.exploreCollectionView {
            print("explore")
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ExploreCell", for: indexPath) as? ExploreCollectionViewCell else { fatalError("cannot make ExploreCell") }
            let city = categoryCities[indexPath.item]
            cell.cityNameLabel.text = city.name

//            let work = DispatchWorkItem { [weak self] in
//                if let imageData = self?.imageDataCache[city.name] {
//                    DispatchQueue.main.async {
//                        cell.imageView.image = UIImage(data: imageData)
//                    }
//                } else {
//                    if let imageURL = URL(string: city.photoMobile ?? "") {
//                        if let imageData = try? Data(contentsOf: imageURL) {
//                            DispatchQueue.main.async {
//                                cell.collectionViewHeight = collectionView.bounds.height
//                                cell.imageView.image = UIImage(data: imageData)
//                            }
//                        }
//                    }
//                }
//            }

//            DispatchQueue.global().async { [weak self] in
//                if let workItem = self?.workItemCache[cell] {
//                    workItem.cancel()
//                }
//                work.perform()
//            }
            return cell
      }
        fatalError("here")
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 200, height: popularCollectionView.bounds.height)
    }
    
    
}
