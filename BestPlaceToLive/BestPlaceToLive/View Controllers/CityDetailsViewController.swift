//
//  CityDetailsViewController.swift
//  BestPlaceToLive
//
//  Created by Bradley Yin on 11/18/19.
//  Copyright © 2019 bradleyyin. All rights reserved.
//

import UIKit

class CityDetailsViewController: UIViewController {
    var city: City?
    let coreDataController = CoreDataController()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    private func updateViews() {
        guard let city = city else { return }
        //update views here
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
