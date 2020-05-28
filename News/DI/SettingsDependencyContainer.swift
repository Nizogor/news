//
//  SettingsDependencyContainer.swift
//  News
//
//  Created by Nikita Teplyakov on 28.05.2020.
//  Copyright © 2020 Nikita Teplyakov. All rights reserved.
//

class SettingsDependencyContainer {

	// MARK: - Properties

	let tabBarDependencyContainer: TabBarDependencyContainer

	// MARK: - Construction

	init(tabBarDependencyContainer: TabBarDependencyContainer) {
		self.tabBarDependencyContainer = tabBarDependencyContainer
	}

	// MARK: - Methods

	func makeUpdateTimeSettingsViewModel() -> UpdateTimeSettingsViewModelProtocol {
		return UpdateTimeSettingsViewModel(settingsService: tabBarDependencyContainer.settingsService)
	}
}
