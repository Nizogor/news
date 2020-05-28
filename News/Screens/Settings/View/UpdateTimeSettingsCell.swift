//
//  UpdateTimeSettingsCell.swift
//  News
//
//  Created by Nikita Teplyakov on 28.05.2020.
//  Copyright © 2020 Nikita Teplyakov. All rights reserved.
//

import UIKit

class UpdateTimeSettingsCell: UITableViewCell {

	// MARK: - Properties

	static let identifier = "UpdateTimeSettingsCell"

	// MARK: - Private Properties

    private var viewModel: UpdateTimeSettingsViewModelProtocol?

	private let label = UILabel()
	private let stepper = UIStepper()

	// MARK: - Construction

	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)

		selectionStyle = .none

		contentView.addSubview(label)
		label.autoPinEdge(toSuperviewEdge: .leading, withInset: 20)
		label.autoAlignAxis(.horizontal, toSameAxisOf: self)

		contentView.addSubview(stepper)
		stepper.autoPinEdge(toSuperviewEdge: .trailing, withInset: 20)
		stepper.autoAlignAxis(.horizontal, toSameAxisOf: self)
		stepper.addTarget(self, action: #selector(stepperDidChangeValue), for: .valueChanged)
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	// MARK: - Methods

	func setup(viewModel: UpdateTimeSettingsViewModelProtocol) {
		self.viewModel = viewModel
		viewModel.delegate = self

		stepper.value = viewModel.value
		stepper.stepValue = viewModel.step
		stepper.minimumValue = viewModel.minimumValue

		update()
	}

	// MARK: - Private Methods

	private func update() {
		guard let aViewModel = viewModel else { return }

		stepper.value = aViewModel.value
		label.text = String(aViewModel.text)
	}

	@objc private func stepperDidChangeValue() {
		viewModel?.stepperValueChanged(newValue: stepper.value)
	}
}

extension UpdateTimeSettingsCell: UpdateTimeSettingsViewModelDelegate {
	func viewModelDidUpdateState() {
		update()
	}
}
