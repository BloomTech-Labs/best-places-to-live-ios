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
    @IBOutlet var factor6Button: UIButton!
    @IBOutlet var exploreButton: UIButton!
    @IBOutlet var savePreferencesButton: UIButton!
    
    //array of breakdown or whatever the method call takes
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    @IBAction func doneButtonTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func factor1Tapped(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        switch sender.isSelected {
        case true:
            sender.backgroundColor = .yellow
            //add the filter type to the array which corresponds to this
        default:
            sender.backgroundColor = .white
            //remove the filter type from the array
        }
    }
    
    @IBAction func factor2Tapped(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        switch sender.isSelected {
        case true:
            sender.backgroundColor = .yellow
            //add the filter type to the array which corresponds to this
        default:
            sender.backgroundColor = .white
            //remove the filter type from the array
        }
    }
    
    @IBAction func factor3Tapped(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        switch sender.isSelected {
        case true:
            sender.backgroundColor = .yellow
            //add the filter type to the array which corresponds to this
        default:
            sender.backgroundColor = .white
            //remove the filter type from the array
        }
    }
    @IBAction func factor4Tapped(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        switch sender.isSelected {
        case true:
            sender.backgroundColor = .yellow
            //add the filter type to the array which corresponds to this
        default:
            sender.backgroundColor = .white
            //remove the filter type from the array
        }
    }
    
    @IBAction func factor5Tapped(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        switch sender.isSelected {
        case true:
            sender.backgroundColor = .yellow
            //add the filter type to the array which corresponds to this
        default:
            sender.backgroundColor = .white
            //remove the filter type from the array
        }
    }
    
    @IBAction func factor6Tapped(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        switch sender.isSelected {
        case true:
            sender.backgroundColor = .yellow
            //add the filter type to the array which corresponds to this
        default:
            sender.backgroundColor = .white
            //remove the filter type from the array
        }
    }
    
    private func setupUI() {
        factor1Button.layer.cornerRadius = 10
        factor2Button.layer.cornerRadius = 10
        factor3Button.layer.cornerRadius = 10
        factor4Button.layer.cornerRadius = 10
        factor5Button.layer.cornerRadius = 10
        factor6Button.layer.cornerRadius = 10
        factor1Button.layer.borderWidth = 2
        factor2Button.layer.borderWidth = 2
        factor3Button.layer.borderWidth = 2
        factor4Button.layer.borderWidth = 2
        factor5Button.layer.borderWidth = 2
        factor6Button.layer.borderWidth = 2
        factor1Button.backgroundColor = .white
        factor2Button.backgroundColor = .white
        factor3Button.backgroundColor = .white
        factor4Button.backgroundColor = .white
        factor5Button.backgroundColor = .white
        factor6Button.backgroundColor = .white
        savePreferencesButton.layer.cornerRadius = 10
        savePreferencesButton.backgroundColor = .white
        savePreferencesButton.layer.borderWidth = 2
        exploreButton.layer.cornerRadius = 10
        exploreButton.backgroundColor = .white
        exploreButton.layer.borderWidth = 2
    }
    
}
