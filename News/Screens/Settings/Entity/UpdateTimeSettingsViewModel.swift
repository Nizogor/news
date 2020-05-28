//
//  UpdateTimeSettingsViewModel.swift
//  News
//
//  Created by Nikita Teplyakov on 28.05.2020.
//  Copyright © 2020 Nikita Teplyakov. All rights reserved.
//

import NewsKit

class UpdateTimeSettingsViewModel {

	// MARK: - Properties

	weak var delegate: UpdateTimeSettingsViewModelDelegate?

	let step: Double = 1
	let minimumValue: Double = 5

	var text: String {
		let intValue = Int(value)
		return String(intValue)
	}

	var value: Double {
		return settingsService.updatePeriod
	}

	// MARK: - Private Properties

	private let settingsService: SettingsServiceProtocol

	// MARK: - Construction

	init(settingsService: SettingsServiceProtocol) {
		self.settingsService = settingsService
	}
}

// MARK: - UpdateTimeSettingsViewModelProtocol

extension UpdateTimeSettingsViewModel: UpdateTimeSettingsViewModelProtocol {
	func stepperValueChanged(newValue: Double) {
		settingsService.updatePeriod = Double(newValue)
		delegate?.viewModelDidUpdateState()
	}
}
