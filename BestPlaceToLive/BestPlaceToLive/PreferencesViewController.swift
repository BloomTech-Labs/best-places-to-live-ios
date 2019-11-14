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

    }
    @IBAction func doneButtonTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
