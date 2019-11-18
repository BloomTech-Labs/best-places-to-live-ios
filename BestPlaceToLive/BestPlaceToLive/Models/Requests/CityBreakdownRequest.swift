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
}
