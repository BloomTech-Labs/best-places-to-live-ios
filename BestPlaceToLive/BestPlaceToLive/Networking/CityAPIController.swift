//
//  CityAPIController.swift
//  BestPlaceToLive
//
//  Created by Jeffrey Santana on 11/15/19.
//  Copyright © 2019 bradleyyin. All rights reserved.
//

import Foundation

class CityAPIController {
	
	static let shared = CityAPIController()
	
	private let baseURLString = "https://bestplacesbe-test.herokuapp.com/city"
	private var networkLoader: NetworkDataLoader
	
	init(networkLoader loader: NetworkDataLoader = URLSession.shared) {
		networkLoader = loader
	}
	
	// MARK: - Create
	
	func getCitiesBreakdown(relatedTo searchTerm: String, completion: @escaping (Result<[CityBreakdown], NetworkError>) -> Void) {
		guard let cityURL = URL(string: baseURLString)?.appendingPathComponent("search") else { return }
		var requestURL = URLRequest(url: cityURL)
		
		requestURL.httpMethod = HTTPMethod.post.rawValue
		requestURL.addValue("application/json", forHTTPHeaderField: "Content-Type")
		
		do {
			let searchRequest = SearchRequest(sesarchTerm: searchTerm)
			let encoder = JSONEncoder()
			let data = try encoder.encode(searchRequest)
			
			requestURL.httpBody = data
		} catch  {
			completion(.failure(.notEncoding))
		}
		
		networkLoader.loadData(from: requestURL) { (data, error) in
			if let error = error {
				NSLog("Error creating user: \(error)")
				completion(.failure(.other(error)))
				return
			}
			
			guard let data = data else {
				NSLog("No data was returned")
				completion(.failure(.noData))
				return
			}
			
			do {
				let decoder = JSONDecoder()
				let citiesDict = try decoder.decode([String:[CityBreakdown]].self, from: data)
				
				if let cities = citiesDict.values.first {
					completion(.success(cities))
				}
			} catch {
				completion(.failure(.notDecoding))
			}
		}
	}
	
	func getCityBreakdownAt(lat: String, long: String, zoom: String, limit: String, rand: String, completion: @escaping (Result<[CityBreakdown], NetworkError>) -> Void) {
		var cityURLComponents = URLComponents(string: baseURLString)
		cityURLComponents?.queryItems = [
			URLQueryItem(name: "lat", value: lat),
			URLQueryItem(name: "lng", value: long),
			URLQueryItem(name: "zoom", value: zoom),
			URLQueryItem(name: "limit", value: limit),
			URLQueryItem(name: "rand", value: rand)
		]
		
		guard let cityURL = cityURLComponents?.url else { return }
		var requestURL = URLRequest(url: cityURL)
		
		requestURL.httpMethod = HTTPMethod.post.rawValue
		requestURL.addValue("application/json", forHTTPHeaderField: "Content-Type")
		
		networkLoader.loadData(from: requestURL) { (data, error) in
			if let error = error {
				NSLog("Error creating user: \(error)")
				completion(.failure(.other(error)))
				return
			}
			
			guard let data = data else {
				NSLog("No data was returned")
				completion(.failure(.noData))
				return
			}
			
			do {
				let decoder = JSONDecoder()
				let citiesDict = try decoder.decode([String:[CityBreakdown]].self, from: data)
				
				if let cities = citiesDict.values.first {
					completion(.success(cities))
				}
			} catch {
				completion(.failure(.notDecoding))
			}
		}
	}
	
	func getCityBreakdown(by cityIds: [String], customModel: [Breakdown]?, completion: @escaping (Result<[CityBreakdown], NetworkError>) -> Void) {
		guard let cityURL = URL(string: baseURLString) else { return }
		var requestURL = URLRequest(url: cityURL)
		
		requestURL.httpMethod = HTTPMethod.post.rawValue
		requestURL.addValue("application/json", forHTTPHeaderField: "Content-Type")
				
		do {
			let cityRequest = CitBreakdownRequest(cityIds: cityIds, customModel: customModel)
			let encoder = JSONEncoder()
			let data = try encoder.encode(cityRequest)
			
			requestURL.httpBody = data
		} catch  {
			completion(.failure(.notEncoding))
		}
		
		networkLoader.loadData(from: requestURL) { (data, error) in
			if let error = error {
				NSLog("Error creating user: \(error)")
				completion(.failure(.other(error)))
				return
			}
			
			guard let data = data else {
				NSLog("No data was returned")
				completion(.failure(.noData))
				return
			}
			
			do {
				let decoder = JSONDecoder()
				let citiesDict = try decoder.decode([String:[CityBreakdown]].self, from: data)
				
				if let cities = citiesDict.values.first {
					completion(.success(cities))
				}
			} catch {
				completion(.failure(.notDecoding))
			}
		}
	}
	
	// MARK: - Read
	
	func getAllCities(completion: @escaping (Result<[City], NetworkError>) -> Void) {
		guard let cityURL = URL(string: baseURLString)?.appendingPathComponent("all") else { return }
		var requestURL = URLRequest(url: cityURL)
		
		requestURL.addValue("application/json", forHTTPHeaderField: "Content-Type")
		
		networkLoader.loadData(from: requestURL) { (data, error) in
			if let error = error {
				NSLog("Error creating user: \(error)")
				completion(.failure(.other(error)))
				return
			}
			
			guard let data = data else {
				NSLog("No data was returned")
				completion(.failure(.noData))
				return
			}
			
			do {
				let decoder = JSONDecoder()
				decoder.keyDecodingStrategy = .convertFromSnakeCase
				
				let citiesDict = try decoder.decode([String:[City]].self, from: data)
				
				if let cities = citiesDict.values.first {
					completion(.success(cities))
				}
			} catch {
				completion(.failure(.notDecoding))
			}
		}
	}
	
	func getTopTenBreakdown(completion: @escaping (Result<[CityBreakdown], NetworkError>) -> Void) {
		guard let topTenURL = URL(string: baseURLString)?.appendingPathComponent("topten-score_total") else { return }
		
		networkLoader.loadData(from: topTenURL) { (data, error) in
			if let error = error {
				NSLog("Error creating user: \(error)")
				completion(.failure(.other(error)))
				return
			}
			
			guard let data = data else {
				NSLog("No data was returned")
				completion(.failure(.noData))
				return
			}
			
			do {
				let decoder = JSONDecoder()
				
				let citiesDict = try decoder.decode([String:[CityBreakdown]].self, from: data)
				
				if let cities = citiesDict.values.first {
					completion(.success(cities))
				}
			} catch {
				completion(.failure(.notDecoding))
			}
		}
	}
	
	func getFilteredCities(filters: [Breakdown], completion: @escaping (Result<[FilteredCity], NetworkError>) -> Void) {
		guard
			let filterSearchURL = URL(string: "https://bestplacesbe-test.herokuapp.com")?.appendingPathComponent("api")
		else { return }
		var requestURL = URLRequest(url: filterSearchURL)
		
		requestURL.httpMethod = HTTPMethod.post.rawValue
		
		do {
			let filters = FilterRequest(filters: filters)
			let encoder = JSONEncoder()
			let data = try encoder.encode(filters)
			
			requestURL.httpBody = data
		} catch  {
			completion(.failure(.notEncoding))
		}
		
		networkLoader.loadData(from: requestURL) { (data, error) in
			if let error = error {
				NSLog("Error creating user: \(error)")
				completion(.failure(.other(error)))
				return
			}
			
			guard let data = data else {
				NSLog("No data was returned")
				completion(.failure(.noData))
				return
			}
			
			do {
				let decoder = JSONDecoder()
				let cities = try decoder.decode([FilteredCity].self, from: data)
					
				completion(.success(cities))
			} catch {
				completion(.failure(.notDecoding))
			}
		}
	}
	
	// MARK: - Update
	
	
	// MARK: - Delete
	
	
}
