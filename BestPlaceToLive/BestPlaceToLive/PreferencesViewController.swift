//
//  PreferencesViewController.swift
//  BestPlaceToLive
//
//  Created by Luqmaan Khan on 11/12/19.
//  Copyright © 2019 bradleyyin. All rights reserved.
//

import UIKit
protocol SelectedFiltersDelegate {
    func userEnteredFilters(filters: [Breakdown])
}

class PreferencesViewController: UIViewController {
    
    @IBOutlet var factor1Button: UIButton!
    @IBOutlet var factor2Button: UIButton!
    @IBOutlet var factor3Button: UIButton!
    @IBOutlet var factor4Button: UIButton!
    @IBOutlet var factor5Button: UIButton!
    @IBOutlet var factor6Button: UIButton!
    @IBOutlet var exploreButton: UIButton!
    
    var selectedFilters: [Breakdown] = []
    var filtersDelegate: SelectedFiltersDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    @IBAction func doneButtonTapped(_ sender: Any) {
            filtersDelegate?.userEnteredFilters(filters: selectedFilters)
        
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func factor1Tapped(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        switch sender.isSelected {
        case true:
            sender.backgroundColor = .yellow
            selectedFilters.append(.costOfLiving)
        default:
            sender.backgroundColor = .white
            selectedFilters.removeAll {$0 == .costOfLiving}
        }
    }
    
    @IBAction func factor2Tapped(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        switch sender.isSelected {
        case true:
            sender.backgroundColor = .yellow
            selectedFilters.append(.scoreSafety)
        default:
            sender.backgroundColor = .white
            selectedFilters.removeAll {$0 == .scoreSafety}
        }
    }
    
    @IBAction func factor3Tapped(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        switch sender.isSelected {
        case true:
            sender.backgroundColor = .yellow
            selectedFilters.append(.scoreEducation)
        default:
            sender.backgroundColor = .white
            selectedFilters.removeAll {$0 == .scoreEducation}
        }
    }
    @IBAction func factor4Tapped(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        switch sender.isSelected {
        case true:
            sender.backgroundColor = .yellow
            selectedFilters.append(.scoreLeisureAndCulture)
        default:
            sender.backgroundColor = .white
            selectedFilters.removeAll {$0 == .scoreLeisureAndCulture}
        }
    }
    
    @IBAction func factor5Tapped(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        switch sender.isSelected {
        case true:
            sender.backgroundColor = .yellow
            selectedFilters.append(.scoreOutdoors)
        default:
            sender.backgroundColor = .white
            selectedFilters.removeAll {$0 == .scoreOutdoors}
        }
    }
    
    @IBAction func factor6Tapped(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        switch sender.isSelected {
        case true:
            sender.backgroundColor = .yellow
            selectedFilters.append(.scoreCommute)
        default:
            sender.backgroundColor = .white
            selectedFilters.removeAll {$0 == .scoreCommute}
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
        exploreButton.layer.cornerRadius = 10
        exploreButton.backgroundColor = .white
        exploreButton.layer.borderWidth = 2
    }
    
}
