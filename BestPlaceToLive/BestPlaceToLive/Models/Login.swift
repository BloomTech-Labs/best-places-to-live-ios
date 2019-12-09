//
//  Login.swift
//  BestPlaceToLive
//
//  Created by Jeffrey Santana on 11/12/19.
//  Copyright © 2019 bradleyyin. All rights reserved.
//

import Foundation

struct Login: Decodable {
	
	let id: String
	let name: String
	let email: String
	let appleId: String?
	let location: String?
	let token: String
	let likes: [City]
	let dislikes: [City]
	let factors: [String]
	
	enum CodingKeys: String, CodingKey {
		case id = "_id"
		case name, email, appleId, location, token, likes, dislikes, factors
	}
}
