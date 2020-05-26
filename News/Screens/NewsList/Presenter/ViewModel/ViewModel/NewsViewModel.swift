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

	var shouldShowSource: Bool {
		didSet { delegate?.viewModelDidUpdate(shouldShowSource: shouldShowSource) }
	}

	var isRead: Bool {
		didSet { delegate?.viewModelDidUpdate(isRead: isRead) }
	}

	var isCollapsed = true {
		didSet { delegate?.viewModelDidUpdate(isCollapsed: isCollapsed) }
	}

	let source: String
	let link: String
	let date: String
	let title: String
	let imageLink: String?
	let description: String

	// MARK: - Private Properties

	private let networkService: NetworkServiceProtocol

	private(set) var imageData: Data? {
		didSet { delegate?.viewModelDidUpdateImage() }
	}

	private(set) var isLoading: Bool = false {
		didSet { delegate?.viewModelDidUpdate(isLoading: isLoading) }
	}

	// MARK: - Construction

	init(networkService: NetworkServiceProtocol,
		 rssDateFormatter: DateFormatter,
		 dateFormatter: DateFormatter,
		 news: News,
		 shouldShowSource: Bool,
		 isRead: Bool) {
		self.networkService = networkService
		self.shouldShowSource = shouldShowSource
		self.isRead = isRead

		if let aDate = rssDateFormatter.date(from: news.date) {
			date = dateFormatter.string(from: aDate)
		} else {
			date = news.date
		}

		source = news.source
		link = news.link
		title = news.title
		imageLink = news.imageLink
		description = news.description
	}

	// MARK: - Private Methods

	func downloadImage() {
		guard imageData == nil, let link = imageLink, isLoading == false else {
			return
		}

		isLoading = true

		networkService.downloadResource(link: link) { [weak self] result in
			guard let self = self else { return }

			self.imageData = try? result.get()
			self.isLoading = false
		}
	}
}

// MARK: - NewsPresenterViewModelProtocol

extension NewsViewModel: NewsPresenterViewModelProtocol {

}

// MARK: - NewsViewModelProtocol

extension NewsViewModel: NewsViewModelProtocol {
	func detailsButtonTap() {
		isCollapsed.toggle()
	}
}
