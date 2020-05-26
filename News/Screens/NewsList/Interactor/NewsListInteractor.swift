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

	var isLoading: Bool {
		return downloadCompletion != nil
	}

	// MARK: - Private Properties
	private let networkService: NetworkServiceProtocol
	private let newsParserFactory: NewsParserFactoryProtocol
	private let saveService: SaveServiceProtocol

	private var downloadCompletion: (([NewsDTO]) -> ())?

	// MARK: - Construction

	init(networkService: NetworkServiceProtocol,
		 newsParserFactory: NewsParserFactoryProtocol,
		 saveService: SaveServiceProtocol) {
		self.networkService = networkService
		self.newsParserFactory = newsParserFactory
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

	func updateNews(from newsSources: [NewsSource]) {
		let group = DispatchGroup()
		var results = [Result<[NewsDTO], Error>]()

		downloadCompletion = { [weak self] news in
			self?.downloadCompletion = nil
			self?.saveService.saveNews(news)
		}

		newsSources.forEach { newsSource in
			group.enter()

			self.networkService.downloadResource(link: newsSource.link) { [weak self] result in
				guard let self = self else { return }

				switch result {
				case .success(let data):
					self.parseNewsData(data, source: newsSource.name) { parsingResult in
						results.append(parsingResult)
						group.leave()
					}
				case .failure(let error):
					results.append(.failure(error))
					group.leave()
				}
			}
		}

		group.notify(queue: DispatchQueue.main) { [weak self] in
			do {
				let news = try results.compactMap { try $0.get() }.flatMap { $0 }
				self?.downloadCompletion?(news)
			} catch {
				print(error.localizedDescription)
			}
		}
	}

	// MARK: - Private Methods

	private func parseNewsData(_ data: Data, source: String, completion: @escaping (Result<[NewsDTO], Error>) -> ()) {
		let parser = self.newsParserFactory.makeNewsParser(data: data)

		parser.fetchNews { result in
			switch result {
			case .success(let models):
				let newsModels = models.map {
					NewsDTO(source: source,
							link: $0.link,
							date: $0.pubDate,
							title: $0.title,
							imageLink: $0.enclosure,
							description: $0.description)
				}

				completion(.success(newsModels))
			case .failure(let error):
				completion(.failure(error))
			}
		}
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
