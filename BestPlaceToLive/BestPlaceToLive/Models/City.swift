//
//  City.swift
//  BestPlaceToLive
//
//  Created by Jeffrey Santana on 11/12/19.
//  Copyright © 2019 bradleyyin. All rights reserved.
//

import Foundation

struct City: Decodable {
	let id: String
	let name: String
	let photo: String?
	
	enum CodingKeys: String, CodingKey {
		case id = "_id"
		case name, photo
	}
}
