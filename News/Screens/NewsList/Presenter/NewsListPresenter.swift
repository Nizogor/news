//
//  NewsListPresenter.swift
//  News
//
//  Created by Nikita Teplyakov on 18/05/2020.
//  Copyright © 2020 Nikita Teplyakov. All rights reserved.
//

class NewsListPresenter {

    // MARK: - Properties
    
    weak var delegate: NewsListPresenterDelegate?

    private let interactor: NewsListInteractorProtocol
    private let router: NewsListRouterProtocol

    // MARK: - Construction

    init(interactor: NewsListInteractorProtocol, router: NewsListRouterProtocol) {
        self.interactor = interactor
        self.router = router
    }
}

// MARK: - NewsListPresenterProtocol

extension NewsListPresenter: NewsListPresenterProtocol {

}

// MARK: - NewsListInteractorDelegate

extension NewsListPresenter: NewsListInteractorDelegate {

}