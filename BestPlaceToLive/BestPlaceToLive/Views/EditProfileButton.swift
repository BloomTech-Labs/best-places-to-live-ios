//
//  EditProfileButton.swift
//  BestPlaceToLive
//
//  Created by Jeffrey Santana on 12/17/19.
//  Copyright © 2019 bradleyyin. All rights reserved.
//

import UIKit

@IBDesignable
class EditProfileButton: UIView {
	
	// MARK: IBOutlets
	
	private lazy var taskImgView: UIImageView = {
		let imgView = UIImageView()
		imgView.translatesAutoresizingMaskIntoConstraints = false
		return imgView
	}()
	private lazy var taskLbl: UILabel = {
		let label = UILabel()
		label.font = UIFont(name: label.font.fontName, size: 20)
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
	}()
	private lazy var moreImgView: UIImageView = {
		let imgView = UIImageView()
		imgView.image = UIImage(systemName: "chevron.right")
		imgView.tintColor = .lightGray
		imgView.translatesAutoresizingMaskIntoConstraints = false
		return imgView
	}()
	private lazy var stackView: UIStackView = {
		let stack = UIStackView()
		stack.axis = .horizontal
		stack.alignment = .center
		stack.spacing = 15
		stack.translatesAutoresizingMaskIntoConstraints = false
		return stack
	}()
	
	// MARK: Properties
	
	@IBInspectable
	var symbolImage: UIImage? {
		get { taskImgView.image }
		set { taskImgView.image = newValue }
	}
	
	@IBInspectable
	var symbolColor: UIColor? {
		get { taskImgView.tintColor }
		set {
			taskImgView.tintColor = newValue
		}
	}
	
	@IBInspectable
	var taskLabel: String? {
		get { taskLbl.text ?? "Task" }
		set { taskLbl.text = newValue }
	}
	
	// MARK: Life Cycle
	
	override func prepareForInterfaceBuilder() {
		setupViews()
	}
	
	override func awakeFromNib() {
		super.awakeFromNib()
		setupViews()
	}
	
	// MARK: IBActions
	
	@IBAction func buttonTapped(_ sender: Any) {
		
	}
	
	// MARK: Helpers
	
	private func setupViews() {
		stackView.addArrangedSubview(taskImgView)
		stackView.addArrangedSubview(taskLbl)
		stackView.addArrangedSubview(moreImgView)
		addSubview(stackView)
		
		NSLayoutConstraint.activate([
			stackView.centerXAnchor.constraint(equalTo: centerXAnchor),
			stackView.centerYAnchor.constraint(equalTo: centerYAnchor),
			stackView.heightAnchor.constraint(equalTo: heightAnchor),
			stackView.widthAnchor.constraint(equalTo: widthAnchor),
			
			taskImgView.heightAnchor.constraint(equalTo: stackView.heightAnchor, multiplier: 0.6),
			taskImgView.widthAnchor.constraint(equalTo: taskImgView.heightAnchor),
			
			moreImgView.heightAnchor.constraint(equalTo: stackView.heightAnchor, multiplier: 0.4),
			moreImgView.widthAnchor.constraint(equalTo: moreImgView.heightAnchor, multiplier: 0.9),
		])
	}

}
