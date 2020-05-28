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
	private let rssDateFormatter = DateFormatter()
	private let dateFormatter = DateFormatter()

	// MARK: - Construction

	init(networkService: NetworkServiceProtocol) {
		self.networkService = networkService

		rssDateFormatter.dateFormat = "E, d MMM yyyy HH:mm:ss Z"
		dateFormatter.dateFormat = "dd.MM.yyyy HH:mm"
	}
}

extension NewsViewModelFactory: NewsViewModelFactoryProtocol {
	func makeNewsViewModel(news: News,
						   isRead: Bool,
						   isOpen: Bool) -> NewsPresenterViewModelProtocol {
		return NewsViewModel(networkService: networkService,
							 rssDateFormatter: rssDateFormatter,
							 dateFormatter: dateFormatter,
							 news: news,
							 isRead: isRead,
							 isOpen: isOpen)
	}
}
