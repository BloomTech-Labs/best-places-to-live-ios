//
//  LikesAndFactors.swift
//  BestPlaceToLive
//
//  Created by Jeffrey Santana on 12/9/19.
//  Copyright © 2019 bradleyyin. All rights reserved.
//

import Foundation

struct LikesAndFactors: Decodable {
	let likes: [CityBreakdown]
	let dislikes: [CityBreakdown]
	let factors: [String]
}
