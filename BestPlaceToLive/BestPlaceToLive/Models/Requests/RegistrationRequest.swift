//
//  RegistrationRequest.swift
//  BestPlaceToLive
//
//  Created by Jeffrey Santana on 11/14/19.
//  Copyright © 2019 bradleyyin. All rights reserved.
//

import Foundation

struct RegistrationRequest: Codable {
	let name: String
	let email: String
	let password: String
	let location: String?
}
