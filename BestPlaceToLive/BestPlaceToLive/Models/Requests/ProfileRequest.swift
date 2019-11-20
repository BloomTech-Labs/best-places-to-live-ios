//
//  ProfileRequest.swift
//  BestPlaceToLive
//
//  Created by Jeffrey Santana on 11/18/19.
//  Copyright © 2019 bradleyyin. All rights reserved.
//

import Foundation

struct ProfileRequest: Codable {
	let name: String?
	let email: String?
	let password: String?
}

