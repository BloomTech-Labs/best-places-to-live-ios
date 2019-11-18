//
//  NetworkingTests.swift
//  BestPlaceToLiveTests
//
//  Created by Jeffrey Santana on 11/13/19.
//  Copyright © 2019 bradleyyin. All rights reserved.
//

import XCTest
@testable import BestPlaceToLive

class NetworkingTests: XCTestCase {
	
	var userController: UserAPIController!
	var cityController: CityAPIController!
	let mockLoader = MockDataLoader()
	
	//MARK: - City Tests
	
	func testGetAllCities() {
		let didFinish = expectation(description: "BPTL_API")
		mockLoader.data = cities
		cityController = CityAPIController(networkLoader: mockLoader)
		
		cityController.getAllCities { (results) in
			let cities = try? results.get()
			
			XCTAssertEqual(cities?[0].name, "Fresno, CA")
			didFinish.fulfill()
		}
		
		wait(for: [didFinish], timeout: 5)
	}
	
	func testTopTenBreakDown() {
		let didFinish = expectation(description: "BPTL_API")
		mockLoader.data = topTenDetails
		cityController = CityAPIController(networkLoader: mockLoader)
		
		cityController.getTopTenBreakdown { (results) in
			let cities = try? results.get()
			
			XCTAssertEqual(cities?.count, 10)
			didFinish.fulfill()
		}
		
		wait(for: [didFinish], timeout: 5)
	}
	
	func testCitiesBreakDown() {
		let didFinish = expectation(description: "BPTL_API")
		mockLoader.data = citiesDetails
		cityController = CityAPIController(networkLoader: mockLoader)
		
		cityController.getCityBreakdown(by: ["5dc9f97b2a65b6af02025ded", "5dc9f97b2a65b6af02025df0"], completion: { (results) in
			let cities = try? results.get()
			
			XCTAssertEqual(cities?.count, 2)
			didFinish.fulfill()
		})
		
		wait(for: [didFinish], timeout: 5)
	}
	
	func testCitiesBreakDownfromLocation() {
		let didFinish = expectation(description: "BPTL_API")
		mockLoader.data = citiesByLocation
		cityController = CityAPIController(networkLoader: mockLoader)
		
		cityController.getCityBreakdownAt(lat: "32", long: "30", zoom: "5", limit: "10", rand: "20", completion: { (results) in
			let cities = try? results.get()
			
			XCTAssertEqual(cities?.compactMap({$0.state}), ["New Mexico", "New Mexico"])
			didFinish.fulfill()
		})
		
		wait(for: [didFinish], timeout: 5)
	}
	
	func testCitiesBreakDownfromSearch() {
		let didFinish = expectation(description: "BPTL_API")
		mockLoader.data = citiesBySearchTerm
		cityController = CityAPIController(networkLoader: mockLoader)
		
		cityController.getCitiesBreakdown(relatedTo: "Hialeh", completion: { (results) in
			let cities = try? results.get()
			
			XCTAssertEqual(cities?.compactMap({$0.state}), ["Florida","Florida"])
			didFinish.fulfill()
		})
		
		wait(for: [didFinish], timeout: 5)
	}
	
	//MARK: - User Tests
	
	func testRegistration() {
		let didFinish = expectation(description: "BPTL_API")
		mockLoader.data = login
		userController = UserAPIController(networkLoader: mockLoader)
		
		userController.registerNewUser(name: "Jack Ryan", email: "jryan@cia.com", password: "123456") { (results) in
			let user = try? results.get()
			
			XCTAssertEqual(user?.name, "Jack Ryan")
			didFinish.fulfill()
		}
		
		wait(for: [didFinish], timeout: 5)
	}
	
	func testLogin() {
		let didFinish = expectation(description: "BPTL_API")
		mockLoader.data = login
		userController = UserAPIController(networkLoader: mockLoader)
		
		userController.login(email: "jryan@cia.com", password: "123456") { (results) in
			let user = try? results.get()
			
			XCTAssertEqual(user?.name, "Jack Ryan")
			didFinish.fulfill()
		}
		
		wait(for: [didFinish], timeout: 5)
	}

}
