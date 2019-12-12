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
	let email: String
	let location: String
	let cities: [City]
	let likes: [CityBreakdown]
	let dislikes: [CityBreakdown]
	let factors: [String]
	
	enum CodingKeys: String, CodingKey {
		case id = "_id"
		case name, email, location, cities, likes, dislikes, factors
	}
}
