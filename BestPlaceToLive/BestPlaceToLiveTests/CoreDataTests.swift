//
//  CoreDataTests.swift
//  BestPlaceToLiveTests
//
//  Created by Luqmaan Khan on 11/15/19.
//  Copyright © 2019 bradleyyin. All rights reserved.
//

import Foundation
import CoreData
import XCTest

@testable import BestPlaceToLive

class CoreDataTests: XCTestCase {
    
    var controller: CoreDataController!
    
    override func setUp() {
        controller = CoreDataController()
    }
    
    func testAddSearchAndFetchSingleSearchFromPersistentStore() {
        let id = UUID().uuidString
        controller.addCitySearch(id: id, cityName: "Name", filters: [""], cityPhoto: "")
        let addedSearch = controller.fetchSingleCitySearchFromPersistence(identifier: id, context: CoreDataStack.shared.mainContext)
        XCTAssertEqual("Name", addedSearch?.cityName )
    }
    
    func testUpdateSearch() {
        let newSearch = CitySearch(id: UUID().uuidString, cityName: "New York", cityPhoto: "", filters: [""])
        controller.updateCitySearch(citySearch: newSearch, cityName: "Palo Alto", filters: [""])
        XCTAssertEqual("Palo Alto", newSearch.cityName)
    }
    
    func testDeleteSearch() {
        let id = UUID().uuidString
        let newSearch = CitySearch(id: id, cityName: "New York", cityPhoto: "", filters: [""])
        controller.deleteCitySearch(citySearch: newSearch)
        XCTAssertNil(controller.fetchSingleCitySearchFromPersistence(identifier: id, context: CoreDataStack.shared.mainContext))
    }
    
    
}
