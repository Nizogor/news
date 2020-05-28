//
//  SourcesListCell.swift
//  News
//
//  Created by Nikita Teplyakov on 28.05.2020.
//  Copyright © 2020 Nikita Teplyakov. All rights reserved.
//

import UIKit

class SourcesListCell: UITableViewCell {

	// MARK: - Properties

	static let identifier = "SourcesListCell"

	// MARK: - Construction

	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	// MARK: - Methods

	func setup(model: SourcesListSettingsModel) {
		textLabel?.text = model.title
		accessoryType = model.isOn ? .checkmark : .none
	}
}
