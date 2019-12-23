//
//  UserInfo.swift
//  BestPlaceToLive
//
//  Created by Jeffrey Santana on 12/5/19.
//  Copyright © 2019 bradleyyin. All rights reserved.
//

import Foundation

struct UserInfo: Decodable {
	
	let id: String
	let name: String
	var email: String
	let appleId: String?
	let token: String?
	var location: String?
	let cities: [City]?
	var likes: [CityBreakdown]?
	var dislikes: [CityBreakdown]?
	var factors: [String]?
	
	enum CodingKeys: String, CodingKey {
		case id = "_id"
		case name, email, appleId, token, location, cities, likes, dislikes, factors
	}
}
