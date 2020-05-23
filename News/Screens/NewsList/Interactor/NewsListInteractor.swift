//
//  NewsListInteractor.swift
//  News
//
//  Created by Nikita Teplyakov on 18/05/2020.
//  Copyright © 2020 Nikita Teplyakov. All rights reserved.
//

import NewsKit

class NewsListInteractor {

    // MARK: - Properties

    weak var delegate: NewsListInteractorDelegate?

	// MARK: - Private Properties

	private let networkService: NetworkServiceProtocol
	private let saveService: SaveServiceProtocol

	// MARK: - Construction

	init(networkService: NetworkServiceProtocol,
		 saveService: SaveServiceProtocol) {
		self.networkService = networkService
		self.saveService = saveService

		setup()
	}

	// MARK: - Private Methods

	private func setup() {
		saveService.delegate = self
	}
}

// MARK: - NewsListInteractorProtocol

extension NewsListInteractor: NewsListInteractorProtocol {

	var readNewsLinks: Set<String> {
		return saveService.readNewsLinks()
	}

	func addReadNewsLink(_ link: String) {
		saveService.saveReadNewsLink(link)
	}

	func updateNews() {

	}
}

// MARK: - SaveServiceDelegate

extension NewsListInteractor: SaveServiceDelegate {
	func saveService(_ saveService: SaveServiceProtocol, didUpdateNews news: [NewsDTO]) {
		let models = news.map {
			News(source: $0.source,
				 link: $0.link,
				 date: $0.date,
				 title: $0.title,
				 imageLink: $0.imageLink,
				 description: $0.description)
		}

		delegate?.newsListInteractor(self, didUpdateNews: models)
	}

	func saveService(_ saveService: SaveServiceProtocol, didUpdateReadNewsLinks links: Set<String>) {
		delegate?.newsListInteractor(self, didUpdateReadNewsLinks: links)
	}
}
