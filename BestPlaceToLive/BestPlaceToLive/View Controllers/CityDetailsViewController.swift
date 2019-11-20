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
    
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var cityPhotoImageView: UIImageView!
    
    
    var city: CityBreakdown?
    let coreDataController = CoreDataController()

    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()

        // Do any additional setup after loading the view.
    }
    
    private func updateViews() {
        guard let city = city else { return }
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
    }
    
    private func checkIfCityIsSaved() {
        guard let cityID = city?.id else { return }
        
        
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
