//
//  ProfileCityRequest.swift
//  BestPlaceToLive
//
//  Created by Jeffrey Santana on 11/18/19.
//  Copyright © 2019 bradleyyin. All rights reserved.
//

import Foundation

struct ProfileCityRequest: Encodable {
	let cityID: String?
	let cityName: String?
	let cityPhoto: String?
}
