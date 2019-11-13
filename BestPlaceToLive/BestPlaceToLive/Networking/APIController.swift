//
//  APIController.swift
//  BestPlaceToLive
//
//  Created by Jeffrey Santana on 11/12/19.
//  Copyright © 2019 bradleyyin. All rights reserved.
//

import Foundation

enum NetworkError: Error {
	case badURL
	case noToken
	case noData
	case notDecoding
	case notEncoding
	case other(Error)
}

enum HTTPMethod: String {
	case get = "GET"
	case put = "PUT"
	case post = "POST"
	case delete = "DELETE"
}

class APIController {
	
	static let shared = APIController()
	
	private let baseURLString = "https://bestplacesbe.herokuapp.com"
	
	// MARK: - Create
	
	
	// MARK: - Read
	
	func getAllCities(completion: @escaping (Result<[City], NetworkError>) -> Void) {
		guard let cityURL = URL(string: baseURLString)?.appendingPathComponent("city/all") else { return }
		var requestURL = URLRequest(url: cityURL)
		
		requestURL.addValue("application/json", forHTTPHeaderField: "Content-Type")
		
		URLSession.shared.dataTask(with: requestURL) { (data, response, error) in
			if let error = error {
				if let response = response as? HTTPURLResponse, response.statusCode != 200 {
					NSLog("Error: status code is \(response.statusCode) instead of 200.")
				}
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
		}.resume()
	}
	
	func getTopTenBreakdown(completion: @escaping (Result<[CityBreakdown], NetworkError>) -> Void) {
		guard let topTenURL = URL(string: baseURLString)?.appendingPathComponent("city/topten-score_total") else { return }
		
		URLSession.shared.dataTask(with: topTenURL) { (data, response, error) in
			if let error = error {
				if let response = response as? HTTPURLResponse, response.statusCode != 200 {
					NSLog("Error: status code is \(response.statusCode) instead of 200.")
				}
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
				
				let citiesDict = try decoder.decode([String:[CityBreakdown]].self, from: data)
				
				if let cities = citiesDict.values.first {
					completion(.success(cities))
				}
			} catch {
				completion(.failure(.notDecoding))
			}
		}.resume()
	}
	
	
	// MARK: - Update
	
	
	// MARK: - Delete
	
	
}
