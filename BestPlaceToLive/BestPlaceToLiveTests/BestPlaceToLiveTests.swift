//
//  BestPlaceToLiveTests.swift
//  BestPlaceToLiveTests
//
//  Created by Jeffrey Santana on 11/13/19.
//  Copyright © 2019 bradleyyin. All rights reserved.
//

import XCTest
@testable import BestPlaceToLive

class BestPlaceToLiveTests: XCTestCase {
	
	var controller: APIController!

    override func setUp() {
		controller = APIController()
    }
	
	func testGetAllCities() {
		let didFinish = expectation(description: "BPTL_API")
		let mockLoader = MockDataLoader()
		mockLoader.data = cities
		controller = APIController(networkLoader: mockLoader)
		
		controller.getAllCities { (results) in
			let cities = try? results.get()
			
			XCTAssertEqual(cities?[0].name, "Fresno, CA")
			didFinish.fulfill()
		}
		
		wait(for: [didFinish], timeout: 5)
	}
	
	func testTopTenBreakDown() {
		let didFinish = expectation(description: "BPTL_API")
		let mockLoader = MockDataLoader()
		mockLoader.data = topTenDetails
		controller = APIController(networkLoader: mockLoader)
		
		controller.getTopTenBreakdown { (results) in
			let cities = try? results.get()
			
			XCTAssertEqual(cities?.count, 10)
			didFinish.fulfill()
		}
		
		wait(for: [didFinish], timeout: 5)
	}
	
	func testRegistration() {
		let didFinish = expectation(description: "BPTL_API")
		let mockLoader = MockDataLoader()
		mockLoader.data = login
		controller = APIController(networkLoader: mockLoader)
		
		controller.registerNewUser(name: "Jack Ryan", email: "jryan@cia.com", password: "123456") { (results) in
			let user = try? results.get()
			
			XCTAssertEqual(user?.name, "Jack Ryan")
			didFinish.fulfill()
		}
		
		wait(for: [didFinish], timeout: 5)
	}
	
	func testLogin() {
		let didFinish = expectation(description: "BPTL_API")
		let mockLoader = MockDataLoader()
		mockLoader.data = login
		controller = APIController(networkLoader: mockLoader)
		
		controller.login(email: "jryan@cia.com", password: "123456") { (results) in
			let user = try? results.get()
			
			XCTAssertEqual(user?.name, "Jack Ryan")
			didFinish.fulfill()
		}
		
		wait(for: [didFinish], timeout: 5)
	}

}
