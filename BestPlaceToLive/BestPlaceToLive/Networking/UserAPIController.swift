//
//  UserAPIController.swift
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

class UserAPIController {
	
	static let shared = UserAPIController()
	
	private let baseURLString = "https://bestplacesbe-test.herokuapp.com/users"
	private let settingsController = SettingsController.shared
	private var networkLoader: NetworkDataLoader
	
	init(networkLoader loader: NetworkDataLoader = URLSession.shared) {
		networkLoader = loader
	}
	
	// MARK: - Create
	
	func registerNewUser(name: String, email: String, password: String, completion: @escaping (Result<Login, NetworkError>) -> Void) {
		guard let cityURL = URL(string: baseURLString)?.appendingPathComponent("register") else { return }
		var requestURL = URLRequest(url: cityURL)
		
		requestURL.httpMethod = HTTPMethod.post.rawValue
		requestURL.addValue("application/json", forHTTPHeaderField: "Content-Type")
		
		do {
			let newUser = RegistrationRequest(name: name, email: email, password: password, location: "Lambda, CA")
			let encoder = JSONEncoder()
			let data = try encoder.encode(newUser)
			
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
	
	func saveCityBy(id: String?, name: String?, photo: String?, completion: @escaping (Result<Profile, NetworkError>) -> Void) {
		guard
			let cityURL = URL(string: baseURLString)?.appendingPathComponent("profile/cities"),
			let userToken = settingsController.userToken
		else { return }
		var requestURL = URLRequest(url: cityURL)
		
		requestURL.httpMethod = HTTPMethod.post.rawValue
		requestURL.addValue("application/json", forHTTPHeaderField: "Content-Type")
		requestURL.addValue(userToken, forHTTPHeaderField: "Authorization")
		
		do {
			let savedCity = ProfileCityRequest(cityID: id, cityName: name, cityPhoto: photo)
			let encoder = JSONEncoder()
			
			encoder.keyEncodingStrategy = .convertToSnakeCase
			let data = try encoder.encode(savedCity)
			
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
				let profile = try decoder.decode(Profile.self, from: data)
				
				completion(.success(profile))
			} catch {
				completion(.failure(.notDecoding))
			}
		}
	}
	
	// MARK: - Read
	
	func login(email: String, password: String, completion: @escaping (Result<Login, NetworkError>) -> Void) {
		guard let cityURL = URL(string: baseURLString)?.appendingPathComponent("login") else { return }
		var requestURL = URLRequest(url: cityURL)
		
		requestURL.httpMethod = HTTPMethod.post.rawValue
		requestURL.addValue("application/json", forHTTPHeaderField: "Content-Type")
		
		do {
			let credentials = LoginRequest(email: email, password: password)
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
	
	func getProfile(completion: @escaping (Result<Profile, NetworkError>) -> Void) {
		guard
			let cityURL = URL(string: baseURLString)?.appendingPathComponent("profile"),
			let userToken = settingsController.userToken
		else { return }
		var requestURL = URLRequest(url: cityURL)
		
		requestURL.addValue("application/json", forHTTPHeaderField: "Content-Type")
		requestURL.addValue(userToken, forHTTPHeaderField: "Authorization")
		
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
				let profile = try decoder.decode(Profile.self, from: data)
				
				completion(.success(profile))
			} catch {
				completion(.failure(.notDecoding))
			}
		}
	}
	
	// MARK: - Update
	
	func updateProfile(name: String?, email: String?, password: String?, completion: @escaping (Result<Profile, NetworkError>) -> Void) {
		guard
			let cityURL = URL(string: baseURLString)?.appendingPathComponent("profile"),
			let userToken = settingsController.userToken
		else { return }
		var requestURL = URLRequest(url: cityURL)
		
		requestURL.httpMethod = HTTPMethod.put.rawValue
		requestURL.addValue("application/json", forHTTPHeaderField: "Content-Type")
		requestURL.addValue(userToken, forHTTPHeaderField: "Authorization")
		
		do {
			let credentials = ProfileRequest(name: name, email: email, password: password)
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
				let profile = try decoder.decode(Profile.self, from: data)
				
				completion(.success(profile))
			} catch {
				completion(.failure(.notDecoding))
			}
		}
	}
	
	// MARK: - Delete
	
	func removeSavedCity(id: String, completion: @escaping (Result<Profile, NetworkError>) -> Void) {
		guard
			let cityURL = URL(string: baseURLString)?.appendingPathComponent("profile/cities"),
			let userToken = settingsController.userToken
		else { return }
		var requestURL = URLRequest(url: cityURL)
		
		requestURL.httpMethod = HTTPMethod.delete.rawValue
		requestURL.addValue("application/json", forHTTPHeaderField: "Content-Type")
		requestURL.addValue(userToken, forHTTPHeaderField: "Authorization")
		
		do {
			let city = ProfileCityRequest(cityID: id, cityName: nil, cityPhoto: nil)
			let encoder = JSONEncoder()
			let data = try encoder.encode(city)
			
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
				let profile = try decoder.decode(Profile.self, from: data)
				
				completion(.success(profile))
			} catch {
				completion(.failure(.notDecoding))
			}
		}
	}
}
