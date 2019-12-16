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
	case custom(String)
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
	
	func registerNewUser(name: String, email: String, password: String, appleId: String?, completion: @escaping (Result<UserInfo, NetworkError>) -> Void) {
		guard let cityURL = URL(string: baseURLString)?.appendingPathComponent(appleId == nil ? "register" : "signup") else { return }
		var requestURL = URLRequest(url: cityURL)
		
		requestURL.httpMethod = HTTPMethod.post.rawValue
		requestURL.addValue("application/json", forHTTPHeaderField: "Content-Type")
		
		do {
			let newUser = RegistrationRequest(name: name, email: email, password: password, appleId: appleId, location: "Lambda, CA")
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
				
				let loginDetails = try decoder.decode(UserInfo.self, from: data)
				
				completion(.success(loginDetails))
			} catch {
				completion(.failure(.notDecoding))
			}
		}
	}
	
	func saveCityBy(id: String?, name: String?, photoUrl: String?, completion: @escaping (Result<Profile, NetworkError>) -> Void) {
		guard
			let cityURL = URL(string: baseURLString)?.appendingPathComponent("profile/cities"),
			let userToken = settingsController.userToken
		else { return }
		var requestURL = URLRequest(url: cityURL)
		
		requestURL.httpMethod = HTTPMethod.post.rawValue
		requestURL.addValue("application/json", forHTTPHeaderField: "Content-Type")
		requestURL.addValue(userToken, forHTTPHeaderField: "Authorization")
		
		do {
			let savedCity = ProfileCityRequest(cityID: id, cityName: name, cityPhoto: photoUrl)
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
	
	func likeCity(id: String, name: String, completion: @escaping (Result<LikesAndFactors, NetworkError>) -> Void) {
		guard let cityURL = URL(string: baseURLString)?.appendingPathComponent("likes"),
		let userToken = settingsController.userToken
			else { return }
		var requestURL = URLRequest(url: cityURL)
		
		requestURL.httpMethod = HTTPMethod.post.rawValue
		requestURL.addValue("application/json", forHTTPHeaderField: "Content-Type")
		requestURL.addValue(userToken, forHTTPHeaderField: "Authorization")
		
		do {
			let cityLike = CityLikeRequest(cityId: id)
			let encoder = JSONEncoder()
			encoder.keyEncodingStrategy = .convertToSnakeCase
			
			let data = try encoder.encode(cityLike)
			
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
				let likesAndFactors = try decoder.decode(LikesAndFactors.self, from: data)
				
				completion(.success(likesAndFactors))
			} catch {
				completion(.failure(.notDecoding))
			}
		}
	}
	
	func dislikeCity(id: String, name: String, completion: @escaping (Result<LikesAndFactors, NetworkError>) -> Void) {
		guard let cityURL = URL(string: baseURLString)?.appendingPathComponent("dislikes"),
		let userToken = settingsController.userToken
			else { return }
		var requestURL = URLRequest(url: cityURL)
		
		requestURL.httpMethod = HTTPMethod.post.rawValue
		requestURL.addValue("application/json", forHTTPHeaderField: "Content-Type")
		requestURL.addValue(userToken, forHTTPHeaderField: "Authorization")
		
		do {
			let cityLike = CityLikeRequest(cityId: id)
			let encoder = JSONEncoder()
			encoder.keyEncodingStrategy = .convertToSnakeCase
			
			let data = try encoder.encode(cityLike)
			
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
				let likesAndFactors = try decoder.decode(LikesAndFactors.self, from: data)
				
				completion(.success(likesAndFactors))
			} catch {
				completion(.failure(.notDecoding))
			}
		}
	}
	
	func addFactor(_ factor: Breakdown, completion: @escaping (Result<LikesAndFactors, NetworkError>) -> Void) {
		guard let cityURL = URL(string: baseURLString)?.appendingPathComponent("factors"),
		let userToken = settingsController.userToken
			else { return }
		var requestURL = URLRequest(url: cityURL)
		
		requestURL.httpMethod = HTTPMethod.post.rawValue
		requestURL.addValue("application/json", forHTTPHeaderField: "Content-Type")
		requestURL.addValue(userToken, forHTTPHeaderField: "Authorization")
		
		do {
			let encoder = JSONEncoder()
			let data = try encoder.encode(["newFactor": factor.rawValue])
			
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
				let likesAndFactors = try decoder.decode(LikesAndFactors.self, from: data)
				
				completion(.success(likesAndFactors))
			} catch {
				completion(.failure(.notDecoding))
			}
		}
	}
	
	// MARK: - Read
	
	func login(email: String, password: String, completion: @escaping (Result<UserInfo, NetworkError>) -> Void) {
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
				
				let loginDetails = try decoder.decode(UserInfo.self, from: data)
				
				completion(.success(loginDetails))
			} catch {
				completion(.failure(.notDecoding))
			}
		}
	}
	
	func login(appleId: String, password: String, completion: @escaping (Result<UserInfo, NetworkError>) -> Void) {
		guard let cityURL = URL(string: baseURLString)?.appendingPathComponent("signin") else { return }
		var requestURL = URLRequest(url: cityURL)
		
		requestURL.httpMethod = HTTPMethod.post.rawValue
		requestURL.addValue("application/json", forHTTPHeaderField: "Content-Type")
		
		do {
			let credentials = LoginWAppleRequest(appleId: appleId, password: password)
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
				
				let loginDetails = try decoder.decode(UserInfo.self, from: data)
				
				completion(.success(loginDetails))
			} catch {
				completion(.failure(.notDecoding))
			}
		}
	}
	
	func getUserInfo(completion: @escaping (Result<UserInfo, NetworkError>) -> Void) {
		guard
			let cityURL = URL(string: baseURLString)?.appendingPathComponent("info"),
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
				decoder.keyDecodingStrategy = .convertFromSnakeCase
				
				let userInfo = try decoder.decode(UserInfo.self, from: data)
				
				completion(.success(userInfo))
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
	
	func updateFactors(_ factors: [Breakdown], completion: @escaping (Result<LikesAndFactors, NetworkError>) -> Void) {
		guard
			let cityURL = URL(string: baseURLString)?.appendingPathComponent("profile"),
			let userToken = settingsController.userToken
		else { return }
		var requestURL = URLRequest(url: cityURL)
		
		requestURL.httpMethod = HTTPMethod.put.rawValue
		requestURL.addValue("application/json", forHTTPHeaderField: "Content-Type")
		requestURL.addValue(userToken, forHTTPHeaderField: "Authorization")
		
		do {
			let factorStrings = factors.map({$0.rawValue})
			let encoder = JSONEncoder()
			let data = try encoder.encode(["putFactors": factorStrings])
			
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
				let likesAndFactors = try decoder.decode(LikesAndFactors.self, from: data)
				
				completion(.success(likesAndFactors))
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
	
	func removeLikedCity(id: String, completion: @escaping (Result<LikesAndFactors, NetworkError>) -> Void) {
		guard
			let cityURL = URL(string: baseURLString)?.appendingPathComponent("likes"),
			let userToken = settingsController.userToken
		else { return }
		var requestURL = URLRequest(url: cityURL)
		
		requestURL.httpMethod = HTTPMethod.delete.rawValue
		requestURL.addValue("application/json", forHTTPHeaderField: "Content-Type")
		requestURL.addValue(userToken, forHTTPHeaderField: "Authorization")
		
		do {
			let cityLike = CityLikeRequest(cityId: id)
			let encoder = JSONEncoder()
			encoder.keyEncodingStrategy = .convertToSnakeCase
			
			let data = try encoder.encode(cityLike)
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
				let likesAndFactors = try decoder.decode(LikesAndFactors.self, from: data)
				
				completion(.success(likesAndFactors))
			} catch {
				completion(.failure(.notDecoding))
			}
		}
	}
	
	func removeDislikedCity(id: String, completion: @escaping (Result<LikesAndFactors, NetworkError>) -> Void) {
		guard
			let cityURL = URL(string: baseURLString)?.appendingPathComponent("dislikes"),
			let userToken = settingsController.userToken
		else { return }
		var requestURL = URLRequest(url: cityURL)
		
		requestURL.httpMethod = HTTPMethod.delete.rawValue
		requestURL.addValue("application/json", forHTTPHeaderField: "Content-Type")
		requestURL.addValue(userToken, forHTTPHeaderField: "Authorization")
		
		do {
			let cityLike = CityLikeRequest(cityId: id)
			let encoder = JSONEncoder()
			encoder.keyEncodingStrategy = .convertToSnakeCase
			
			let data = try encoder.encode(cityLike)
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
				let likesAndFactors = try decoder.decode(LikesAndFactors.self, from: data)
				
				completion(.success(likesAndFactors))
			} catch {
				completion(.failure(.notDecoding))
			}
		}
	}
	
	func removeFactor(_ factor: Breakdown, completion: @escaping (Result<LikesAndFactors, NetworkError>) -> Void) {
		guard
			let cityURL = URL(string: baseURLString)?.appendingPathComponent("factors"),
			let userToken = settingsController.userToken
		else { return }
		var requestURL = URLRequest(url: cityURL)
		
		requestURL.httpMethod = HTTPMethod.delete.rawValue
		requestURL.addValue("application/json", forHTTPHeaderField: "Content-Type")
		requestURL.addValue(userToken, forHTTPHeaderField: "Authorization")
		
		do {
			let encoder = JSONEncoder()
			let data = try encoder.encode(["delFactor": factor.rawValue])
			
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
				let likesAndFactors = try decoder.decode(LikesAndFactors.self, from: data)
				
				completion(.success(likesAndFactors))
			} catch {
				completion(.failure(.notDecoding))
			}
		}
	}
}
