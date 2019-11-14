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
	
	private let baseURLString = "https://bestplacesbe-test.herokuapp.com"
	private var networkLoader: NetworkDataLoader
	
	init(networkLoader loader: NetworkDataLoader = URLSession.shared) {
		networkLoader = loader
	}
	
	// MARK: - Create
	
	func register(user: Login, completion: @escaping (Result<Login, NetworkError>) -> Void) {
		guard let cityURL = URL(string: baseURLString)?.appendingPathComponent("users/register") else { return }
		var requestURL = URLRequest(url: cityURL)
		
		requestURL.addValue("application/json", forHTTPHeaderField: "Content-Type")
		
		do {
			let encoder = JSONEncoder()
			let data = try encoder.encode(user)
			
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
				decoder.keyDecodingStrategy = .convertFromSnakeCase
				
				let loginDetails = try decoder.decode(Login.self, from: data)
				
				completion(.success(loginDetails))
			} catch {
				completion(.failure(.notDecoding))
			}
		}
	}
	
	// MARK: - Read
	
	func login(credentials: LoginRequest, completion: @escaping (Result<Login, NetworkError>) -> Void) {
		guard let cityURL = URL(string: baseURLString)?.appendingPathComponent("users/login") else { return }
		var requestURL = URLRequest(url: cityURL)
		
		requestURL.addValue("application/json", forHTTPHeaderField: "Content-Type")
		
		do {
			let encoder = JSONEncoder()
			let data = try encoder.encode(credentials)
			
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
				decoder.keyDecodingStrategy = .convertFromSnakeCase
				
				let loginDetails = try decoder.decode(Login.self, from: data)
				
				completion(.success(loginDetails))
			} catch {
				completion(.failure(.notDecoding))
			}
		}
	}
	
	func getAllCities(completion: @escaping (Result<[City], NetworkError>) -> Void) {
		guard let cityURL = URL(string: baseURLString)?.appendingPathComponent("city/all") else { return }
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
		guard let topTenURL = URL(string: baseURLString)?.appendingPathComponent("city/topten-score_total") else { return }
		
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
	
	
	// MARK: - Update
	
	
	// MARK: - Delete
	
	
}
