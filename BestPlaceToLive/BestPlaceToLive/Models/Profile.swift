//
//  Profile.swift
//  BestPlaceToLive
//
//  Created by Jeffrey Santana on 11/18/19.
//  Copyright © 2019 bradleyyin. All rights reserved.
//

import Foundation

struct Profile: Decodable {
	
	let id: String
	let name: String
	let email: String
	let cities: [City]
	
	enum CodingKeys: String, CodingKey {
		case id = "_id"
		case name, email, cities
	}
}
