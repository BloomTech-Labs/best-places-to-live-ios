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
            sender.backgroundColor = #colorLiteral(red: 0.5450980392, green: 0.7098039216, blue: 0.9921568627, alpha: 1)
            selectedFilters.append(.costOfLiving)
        default:
            sender.backgroundColor = #colorLiteral(red: 0.9019607843, green: 0.8941176471, blue: 0.9176470588, alpha: 1)
            selectedFilters.removeAll {$0 == .costOfLiving}
        }
    }
    
    @IBAction func factor2Tapped(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        switch sender.isSelected {
        case true:
        
            sender.backgroundColor = #colorLiteral(red: 0.5450980392, green: 0.7098039216, blue: 0.9921568627, alpha: 1)
            selectedFilters.append(.scoreSafety)
        default:
            sender.backgroundColor = #colorLiteral(red: 0.9019607843, green: 0.8941176471, blue: 0.9176470588, alpha: 1)
            selectedFilters.removeAll {$0 == .scoreSafety}
        }
    }
    
    @IBAction func factor3Tapped(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        switch sender.isSelected {
        case true:
            sender.backgroundColor = #colorLiteral(red: 0.5450980392, green: 0.7098039216, blue: 0.9921568627, alpha: 1)
            selectedFilters.append(.scoreEducation)
        default:
            sender.backgroundColor = #colorLiteral(red: 0.9019607843, green: 0.8941176471, blue: 0.9176470588, alpha: 1)
            selectedFilters.removeAll {$0 == .scoreEducation}
        }
    }
    @IBAction func factor4Tapped(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        switch sender.isSelected {
        case true:
            sender.backgroundColor = #colorLiteral(red: 0.5450980392, green: 0.7098039216, blue: 0.9921568627, alpha: 1)
            selectedFilters.append(.scoreLeisureAndCulture)
        default:
            sender.backgroundColor = #colorLiteral(red: 0.9019607843, green: 0.8941176471, blue: 0.9176470588, alpha: 1)
            selectedFilters.removeAll {$0 == .scoreLeisureAndCulture}
        }
    }
    
    @IBAction func factor5Tapped(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        switch sender.isSelected {
        case true:
            sender.backgroundColor = #colorLiteral(red: 0.5450980392, green: 0.7098039216, blue: 0.9921568627, alpha: 1)
            selectedFilters.append(.scoreOutdoors)
        default:
            sender.backgroundColor = #colorLiteral(red: 0.9019607843, green: 0.8941176471, blue: 0.9176470588, alpha: 1)
            selectedFilters.removeAll {$0 == .scoreOutdoors}
        }
    }
    
    @IBAction func factor6Tapped(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        switch sender.isSelected {
        case true:
            sender.backgroundColor = #colorLiteral(red: 0.5450980392, green: 0.7098039216, blue: 0.9921568627, alpha: 1)
            selectedFilters.append(.scoreCommute)
        default:
            sender.backgroundColor = #colorLiteral(red: 0.9019607843, green: 0.8941176471, blue: 0.9176470588, alpha: 1)
            selectedFilters.removeAll {$0 == .scoreCommute}
        }
    }
    
    private func setupUI() {
        
        factor1Button.backgroundColor = #colorLiteral(red: 0.9019607843, green: 0.8941176471, blue: 0.9176470588, alpha: 1)
        factor2Button.backgroundColor = #colorLiteral(red: 0.9019607843, green: 0.8941176471, blue: 0.9176470588, alpha: 1)
        factor3Button.backgroundColor = #colorLiteral(red: 0.9019607843, green: 0.8941176471, blue: 0.9176470588, alpha: 1)
        factor4Button.backgroundColor = #colorLiteral(red: 0.9019607843, green: 0.8941176471, blue: 0.9176470588, alpha: 1)
        factor5Button.backgroundColor = #colorLiteral(red: 0.9019607843, green: 0.8941176471, blue: 0.9176470588, alpha: 1)
        factor6Button.backgroundColor = #colorLiteral(red: 0.9019607843, green: 0.8941176471, blue: 0.9176470588, alpha: 1)
        factor1Button.layer.cornerRadius = 10
        factor2Button.layer.cornerRadius = 10
        factor3Button.layer.cornerRadius = 10
        factor4Button.layer.cornerRadius = 10
        factor5Button.layer.cornerRadius = 10
        factor6Button.layer.cornerRadius = 10
        exploreButton.layer.cornerRadius = 10
        exploreButton.backgroundColor = #colorLiteral(red: 0.01568627451, green: 0.3568627451, blue: 0.9294117647, alpha: 1)
    }
    
}
