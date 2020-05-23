//
//  NewsViewModel.swift
//  News
//
//  Created by Nikita Teplyakov on 18.05.2020.
//  Copyright © 2020 Nikita Teplyakov. All rights reserved.
//

import NewsKit

class NewsViewModel {

	// MARK: - Properties

	weak var delegate: NewsViewModelDelegate? {
		didSet { downloadImage() }
	}

	let shouldShowSource: Bool
	let isRead: Bool

	// MARK: - Private Properties

	private let networkService: NetworkServiceProtocol
	private let news: News

	private(set) var imageData: Data?
	private(set) var isLoading: Bool = false

	// MARK: - Construction

	init(networkService: NetworkServiceProtocol, news: News, shouldShowSource: Bool, isRead: Bool) {
		self.networkService = networkService
		self.news = news
		self.shouldShowSource = shouldShowSource
		self.isRead = isRead
	}

	// MARK: - Private Methods

	private func downloadImage() {
		guard imageData == nil && isLoading == false else { return }

		networkService.downloadResource(link: news.link) { [weak self] result in
			self?.imageData = try? result.get()
			self?.isLoading = false
			self?.delegate?.update()
		}
	}
}

extension NewsViewModel: NewsViewModelProtocol {

	var source: String {
		news.source
	}

	var date: String {
		news.date
	}

	var title: String {
		news.title
	}

	var description: String {
		news.description
	}
}
