//
//  RoundedButton.swift
//  BestPlaceToLive
//
//  Created by Jeffrey Santana on 12/5/19.
//  Copyright © 2019 bradleyyin. All rights reserved.
//

import UIKit

@IBDesignable
class RoundedButton: UIButton {
	
	@IBInspectable var borderColor: UIColor = UIColor.white
	
	override func prepareForInterfaceBuilder() {
		customizeView()
	}
	
	override func awakeFromNib() {
		super.awakeFromNib()
		customizeView()
	}
	
	func customizeView() {
		layer.borderColor = borderColor.cgColor
		layer.borderWidth = 1.5
		layer.cornerCurve = .continuous
		layer.cornerRadius = 10
	}
}
