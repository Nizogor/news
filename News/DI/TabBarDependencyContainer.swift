//
//  TabBarDependencyContainer.swift
//  News
//
//  Created by Nikita Teplyakov on 18.05.2020.
//  Copyright © 2020 Nikita Teplyakov. All rights reserved.
//

import NewsKit

class TabBarDependencyContainer {

	let settingsService: SettingsServiceProtocol = SettingsService()
	let newsSourcesProvider: NewsSourcesProviderProtocol = NewsSourcesProvider()

	func makeNewsListBuilder() -> NewsListBuilder {
		let dependencyContainer = NewsListDependencyContainer(tabBarDependencyContainer: self)
		return NewsListBuilder(dependencyContainer: dependencyContainer)
	}

	func makeSettingsBuilder() -> SettingsBuilder {
		let dependencyContainer = SettingsDependencyContainer(tabBarDependencyContainer: self)
		return SettingsBuilder(dependencyContainer: dependencyContainer)
	}
}
