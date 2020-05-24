//
//  NewsListDependencyContainer.swift
//  News
//
//  Created by Nikita Teplyakov on 18.05.2020.
//  Copyright © 2020 Nikita Teplyakov. All rights reserved.
//

import NewsKit

class NewsListDependencyContainer {

	// MARK: - Properties

	let tabBarDependencyContainer: TabBarDependencyContainer

	let networkService: NetworkServiceProtocol = NetworkService()
	let newsParserFactory: NewsParserFactoryProtocol = NewsParserFactory()
	let saveService: SaveServiceProtocol = SaveService()
	let newsViewModelFactory: NewsViewModelFactoryProtocol

	// MARK: - Construction

	init(tabBarDependencyContainer: TabBarDependencyContainer) {
		self.tabBarDependencyContainer = tabBarDependencyContainer

		newsViewModelFactory = NewsViewModelFactory(networkService: networkService)
	}
}
