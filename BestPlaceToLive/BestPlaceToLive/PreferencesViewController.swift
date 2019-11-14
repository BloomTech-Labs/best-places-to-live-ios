//
//  PreferencesViewController.swift
//  BestPlaceToLive
//
//  Created by Luqmaan Khan on 11/12/19.
//  Copyright © 2019 bradleyyin. All rights reserved.
//

import UIKit

class PreferencesViewController: UIViewController {

    @IBOutlet var factor1Button: UIButton!
    @IBOutlet var factor2Button: UIButton!
    @IBOutlet var factor3Button: UIButton!
    @IBOutlet var factor4Button: UIButton!
    @IBOutlet var factor5Button: UIButton!
    @IBOutlet var exploreButton: UIButton!
    @IBOutlet var savePreferencesButton: UIButton!
    @IBOutlet var distanceFromCityPicker: UIPickerView!
    @IBOutlet var sizeOfCityPicker: UIPickerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    @IBAction func doneButtonTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
   
    private func setupUI() {
        factor1Button.layer.cornerRadius = 10
        factor2Button.layer.cornerRadius = 10
        factor3Button.layer.cornerRadius = 10
        factor4Button.layer.cornerRadius = 10
        factor5Button.layer.cornerRadius = 10
         factor1Button.layer.borderWidth = 2
         factor2Button.layer.borderWidth = 2
         factor3Button.layer.borderWidth = 2
         factor4Button.layer.borderWidth = 2
         factor5Button.layer.borderWidth = 2
        
        factor1Button.layer.borderColor = UIColor(red: 127.0/255.0, green: 198.0/255.0, blue: 164.0/255.0, alpha: 1).cgColor
    }
    
}
