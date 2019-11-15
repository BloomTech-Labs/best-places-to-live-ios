//
//  CoreDataController.swift
//  BestPlaceToLive
//
//  Created by Luqmaan Khan on 11/15/19.
//  Copyright © 2019 bradleyyin. All rights reserved.
//

import Foundation

class CoreDataController {
    
    func saveToPersistentStore() {
        let moc = CoreDataStack.shared.mainContext
        do {
            try moc.save()
        }
        catch {
            NSLog("Error saving to persistent store: \(error)")
            moc.reset()
        }
    }
    
    func addCitySearch(id: UUID, cityName: String, filters: NSArray? = nil, cityPhoto: String? = nil) {
        _ = CitySearch(id: id, cityName: cityName, cityPhoto: cityPhoto ?? "", filters: filters ?? NSArray())
        saveToPersistentStore()
    }
    
    func deleteCitySearch(citySearch: CitySearch) {
        let moc = CoreDataStack.shared.mainContext
        moc.delete(citySearch)
        saveToPersistentStore()
    }
    
    func updateCitySearch(citySearch: CitySearch, cityName: String, filters: NSArray? = nil, cityPhoto: String? = nil) {
        citySearch.cityName = cityName
        citySearch.filters = filters
        citySearch.cityPhoto = cityPhoto
        saveToPersistentStore()
    }
    
}

