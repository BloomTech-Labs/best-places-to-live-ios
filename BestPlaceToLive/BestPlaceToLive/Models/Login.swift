//
//  Login.swift
//  BestPlaceToLive
//
//  Created by Jeffrey Santana on 11/12/19.
//  Copyright © 2019 bradleyyin. All rights reserved.
//

import Foundation

struct Login: Codable {
	enum CodingKeys: String, CodingKey {
		case id = "_id"
		case token
		case username
	}
	
	let id: Int
	let username: String
	let token: String
}
