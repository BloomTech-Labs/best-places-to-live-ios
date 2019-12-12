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
    @IBOutlet var getDirectionsButton: UIButton!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet var shareCityButton: UIButton!
    @IBOutlet weak var cityPhotoImageView: UIImageView!
    
    
    var city: CityBreakdown?
    var filteredCity: FilteredCity?
    let coreDataController = CoreDataController()
    var cityIsSaved = false
    var citySearch: CitySearch?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        likeButton.isUserInteractionEnabled = false
        self.navigationController?.isNavigationBarHidden = false
        updateViews()
        checkIfCityIsSaved()
    }
    @IBAction func shareCityTapped(_ sender: UIButton) {
        let sharedText = "Check out \(cityNameLabel.text!)!"
        let items = [cityPhotoImageView.image!,sharedText ] as [Any]
        let ac = UIActivityViewController(activityItems: items, applicationActivities: nil)
        present(ac, animated: true)
    }
    @IBAction func getDirectionsTapped(_ sender: UIButton) {
        guard let city = city, let location = city.location else {return}
        let appleQuery = "?daddr=\(location[1]),\(location[0])"
        let googleQuery = "?daddr=\(location[1]),\(location[0])"
        let appleUrlString = "http://maps.apple.com/".appending(appleQuery)
        let googleUrlString = "http://maps.google.com/".appending(googleQuery)
        guard let googleUrl = URL(string:googleUrlString), let appleURL = URL(string: appleUrlString) else {return}
        if UIApplication.shared.canOpenURL(googleUrl) {
            UIApplication.shared.open(googleUrl, options: [:], completionHandler: nil)
        } else {
            UIApplication.shared.open(appleURL, options: [:], completionHandler: nil)
        }
    }
    
    func imageResize (image:UIImage, sizeChange:CGSize)-> UIImage{
        let hasAlpha = true
        let scale: CGFloat = 0.0
        
        UIGraphicsBeginImageContextWithOptions(sizeChange, !hasAlpha, scale)
        image.draw(in: CGRect(origin: .zero, size: sizeChange))
        
        let scaledImage = UIGraphicsGetImageFromCurrentImageContext()!
        return scaledImage
    }
    
    private func setupUI() {
        shareCityButton.backgroundColor = .white
        shareCityButton.layer.cornerRadius = 10.0
        shareCityButton.layer.borderWidth = 2
        shareCityButton.layer.shadowRadius = 5
        shareCityButton.layer.shadowOffset = CGSize(width: 5, height: 5)
        shareCityButton.layer.shadowColor = UIColor.black.cgColor
        shareCityButton.layer.shadowOpacity = 1.0
        getDirectionsButton.backgroundColor = .white
        getDirectionsButton.layer.cornerRadius = 10.0
        getDirectionsButton.layer.borderWidth = 2
        getDirectionsButton.layer.shadowRadius = 5
        getDirectionsButton.layer.shadowOffset = CGSize(width: 5, height: 5)
        getDirectionsButton.layer.shadowColor = UIColor.black.cgColor
        getDirectionsButton.layer.shadowOpacity = 1.0
        
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
