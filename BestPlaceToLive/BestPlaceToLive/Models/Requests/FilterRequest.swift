//
//  FilterRequest.swift
//  BestPlaceToLive
//
//  Created by Jeffrey Santana on 11/20/19.
//  Copyright © 2019 bradleyyin. All rights reserved.
//

import Foundation

struct FilterRequest: Encodable {
	let input1: [String]
	
	init(filters: [Breakdown]) {
		input1 = filters.map({$0.rawValue})
	}
}
