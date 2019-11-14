//
//  Extensions.swift
//  BestPlaceToLive
//
//  Created by Jeffrey Santana on 11/14/19.
//  Copyright © 2019 bradleyyin. All rights reserved.
//

import UIKit

extension UITextField {
	var optionalText: String? {
		let trimmedText = self.text?.trimmingCharacters(in: .whitespacesAndNewlines)
		return (trimmedText ?? "").isEmpty ? nil : trimmedText
	}
}
