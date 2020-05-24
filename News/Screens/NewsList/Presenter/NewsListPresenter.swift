//
//  NewsListPresenter.swift
//  News
//
//  Created by Nikita Teplyakov on 18/05/2020.
//  Copyright © 2020 Nikita Teplyakov. All rights reserved.
//

import NewsKit

class NewsListPresenter {

    // MARK: - Properties
    
    weak var delegate: NewsListPresenterDelegate?

	// MARK: - Private Properties

    private let interactor: NewsListInteractorProtocol
    private let router: NewsListRouterProtocol

	private let settingsProvider: SettingsProviderProtocol
	private let newsViewModelFactory: NewsViewModelFactoryProtocol

	private var news = [News]()
	private var readNewsLinks = Set<String>()

    // MARK: - Construction

    init(interactor: NewsListInteractorProtocol,
		 router: NewsListRouterProtocol,
		 settingsProvider: SettingsProviderProtocol,
		 newsViewModelFactory: NewsViewModelFactoryProtocol) {
        self.interactor = interactor
        self.router = router

		self.settingsProvider = settingsProvider
		self.newsViewModelFactory = newsViewModelFactory

		setup()
    }

	deinit {
		settingsProvider.removeDelegate(self)
	}

	// MARK: - Private Methods

	private func setup() {
		settingsProvider.addDelegate(self)
		readNewsLinks = interactor.readNewsLinks
	}
}

// MARK: - NewsListPresenterProtocol

extension NewsListPresenter: NewsListPresenterProtocol {

	var viewModelsCount: Int {
		return news.count
	}

	func viewModelAtIndex(_ index: Int) -> NewsViewModelProtocol {
		let newsModel = news[index]
		let isRead = interactor.readNewsLinks.contains(newsModel.link)

		return newsViewModelFactory.makeNewsViewModel(news: newsModel,
													  shouldShowSource: settingsProvider.shouldShowSource,
													  isRead: isRead)
	}

	func selectViewAtIndex(_ index: Int) {
		let newsModel = news[index]
		interactor.addReadNewsLink(newsModel.link)
	}
}

// MARK: - NewsListInteractorDelegate

extension NewsListPresenter: NewsListInteractorDelegate {
	func newsListInteractor(_ interactor: NewsListInteractorProtocol, didUpdateNews news: [News]) {
		self.news = news

		delegate?.updateNewsList()
	}

	func newsListInteractor(_ interactor: NewsListInteractorProtocol, didUpdateReadNewsLinks links: Set<String>) {
		delegate?.updateNewsList()
	}
}

// MARK: - NewsListPresenter

extension NewsListPresenter: SettingsProviderDelegate {
	func settingsService(_ settingsService: SettingsServiceProtocol, didChangeUpdatePeriod updatePeriod: TimeInterval) {
		
	}

	func settingsService(_ settingsService: SettingsServiceProtocol, didChangeShowingSourcePolicy shouldShowSource: Bool) {
		delegate?.updateNewsList()
	}

	func settingsService(_ settingsService: SettingsServiceProtocol,
						 didChangeDisabledNewsSources newsSources: Set<String>) {

	}
}
