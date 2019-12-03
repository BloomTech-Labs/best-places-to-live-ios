//
//  CityDetailsViewController.swift
//  BestPlaceToLive
//
//  Created by Bradley Yin on 11/18/19.
//  Copyright © 2019 bradleyyin. All rights reserved.
//

import UIKit
import MapKit

class CityDetailsViewController: UIViewController {
    //TODO: Make Filtered City and CityBreakdown correlate
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var cityPhotoImageView: UIImageView!
    
    
    var city: CityBreakdown?
    var filteredCity: FilteredCity?
    let coreDataController = CoreDataController()
    var cityIsSaved = false
    var citySearch: CitySearch?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        likeButton.isUserInteractionEnabled = false
        self.navigationController?.isNavigationBarHidden = false
        updateViews()
        checkIfCityIsSaved()
        
        // Do any additional setup after loading the view.
    }
    
    private func updateViews() {
        if let city = city {
            //update views here
            cityNameLabel.text = city.name
            if let location = city.location {
                let annotaton = MKPointAnnotation()
                annotaton.coordinate = CLLocationCoordinate2D(latitude: location[1], longitude: location[0])
                let span = MKCoordinateSpan(latitudeDelta: 1, longitudeDelta: 1)
                let region = MKCoordinateRegion(center: annotaton.coordinate, span: span)
                self.mapView.setRegion(region, animated: true)
                mapView.addAnnotation(annotaton)
            }
            if let imageURL = URL(string: city.secureURL ?? "") {
                if let imageData = try? Data(contentsOf: imageURL) {
                    cityPhotoImageView.image = UIImage(data: imageData)
                }
            }
            
        }
        if let filteredCity = filteredCity {
            CityAPIController.shared.getCityBreakdown(by: [filteredCity.id], customModel: nil) { result in
                switch result {
                case .failure(let error):
                    NSLog("Error fetching city with id: \(error)")
                    break
                case .success(let cities):
                    print("\(cities)")
                    if let city = cities.first {
                        DispatchQueue.main.async {
                            self.cityNameLabel.text = city.name
                            if let location = city.location {
                                let annotaton = MKPointAnnotation()
                                annotaton.coordinate = CLLocationCoordinate2D(latitude: location[1], longitude: location[0])
                                let span = MKCoordinateSpan(latitudeDelta: 1, longitudeDelta: 1)
                                let region = MKCoordinateRegion(center: annotaton.coordinate, span: span)
                                self.mapView.setRegion(region, animated: true)
                                self.mapView.addAnnotation(annotaton)
                            }
                            if let imageURL = URL(string: city.secureURL ?? "") {
                                if let imageData = try? Data(contentsOf: imageURL) {
                                    self.cityPhotoImageView.image = UIImage(data: imageData)
                                }
                            }
                        }
                    }
                }
            }
        }
    }
        
        private func checkIfCityIsSaved() {
            guard let cityID = city?.id else { return }
            if let savedCity = coreDataController.fetchSingleCitySearchFromPersistence(identifier: cityID) {
                citySearch = savedCity
                //cityIsSaved = true
                likeButton.setImage(UIImage(systemName: "suit.heart.fill"), for: .normal)
            } else {
                //cityIsSaved = false
                likeButton.setImage(UIImage(systemName: "suit.heart"), for: .normal)
            }
            likeButton.isUserInteractionEnabled = true
            
        }
        
        @IBAction func likeButtonTapped(_ sender: Any) {
            guard let city = city, let id = city.id, let name = city.name else { return }
            if let citySearch = citySearch {
                coreDataController.deleteCitySearch(citySearch: citySearch)
                self.citySearch = nil
                likeButton.setImage(UIImage(systemName: "suit.heart"), for: .normal)
                //cityIsSaved.toggle()
            } else {
                citySearch = coreDataController.addCitySearch(id: id, cityName: name, cityPhoto: city.photo, group: Group(name: "test"))
                likeButton.setImage(UIImage(systemName: "suit.heart.fill"), for: .normal)
                //cityIsSaved.toggle()
            }
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
