//
//  UpdateTimeSettingsViewModelProtocol.swift
//  News
//
//  Created by Nikita Teplyakov on 28.05.2020.
//  Copyright © 2020 Nikita Teplyakov. All rights reserved.
//

protocol UpdateTimeSettingsViewModelDelegate: class {
	func viewModelDidUpdateState()
}

protocol UpdateTimeSettingsViewModelProtocol: class {

	var delegate: UpdateTimeSettingsViewModelDelegate? { get set }

	var text: String { get }
	var value: Double { get }
	var step: Double { get }
	var minimumValue: Double { get }

	func stepperValueChanged(newValue: Double)
}
