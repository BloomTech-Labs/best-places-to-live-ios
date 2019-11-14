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
        factor1Button.backgroundColor = .white
        factor2Button.backgroundColor = .white
        factor3Button.backgroundColor = .white
        factor4Button.backgroundColor = .white
        factor5Button.backgroundColor = .white
        savePreferencesButton.layer.cornerRadius = 10
        savePreferencesButton.backgroundColor = .white
        savePreferencesButton.layer.borderWidth = 2
        exploreButton.layer.cornerRadius = 10
        exploreButton.backgroundColor = .white
        exploreButton.layer.borderWidth = 2
    }
    
}


//distance from current city tag = 1
//size of city tag = 2
