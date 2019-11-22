//
//  CityBreakdownRequest.swift
//  BestPlaceToLive
//
//  Created by Jeffrey Santana on 11/15/19.
//  Copyright © 2019 bradleyyin. All rights reserved.
//

import Foundation

struct CitBreakdownRequest: Encodable {
	let ids: [String]
	let model: [String: String]?
	
	init(cityIds: [String], customModel: [Breakdown]?) {
		var newModel: [String: String]?
		customModel?.forEach({ newModel?[$0.rawValue] = "" })
		
		ids = cityIds
		model = newModel
	}
}
