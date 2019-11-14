//
//  Login.swift
//  BestPlaceToLive
//
//  Created by Jeffrey Santana on 11/12/19.
//  Copyright © 2019 bradleyyin. All rights reserved.
//

import Foundation

struct Login: Codable {
	
	let id: String
	let name: String
	let email: String
	let location: String?
	let token: String
	
	enum CodingKeys: String, CodingKey {
		case id = "_id"
		case name, email, location, token
	}
}
