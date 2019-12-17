//
//  FilteredCity.swift
//  BestPlaceToLive
//
//  Created by Jeffrey Santana on 11/20/19.
//  Copyright © 2019 bradleyyin. All rights reserved.
//

import Foundation

struct FilteredCity: Decodable {
	let id: String
	let name: String
	let shortName: String
	let state: String
	let secureUrl: String?
	let population: Double
}
