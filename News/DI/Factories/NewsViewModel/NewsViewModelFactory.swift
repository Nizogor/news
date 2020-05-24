//
//  NewsViewModelFactory.swift
//  News
//
//  Created by Nikita Teplyakov on 18.05.2020.
//  Copyright © 2020 Nikita Teplyakov. All rights reserved.
//

import NewsKit

class NewsViewModelFactory {

	// MARK: - Private Properties

	private let networkService: NetworkServiceProtocol

	// MARK: - Construction

	init(networkService: NetworkServiceProtocol) {
		self.networkService = networkService
	}
}

extension NewsViewModelFactory: NewsViewModelFactoryProtocol {
	func makeNewsViewModel(news: News, shouldShowSource: Bool, isRead: Bool) -> NewsViewModelProtocol {
		return NewsViewModel(networkService: networkService,
							 news: news,
							 shouldShowSource: shouldShowSource,
							 isRead: isRead)
	}
}
