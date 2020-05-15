//
//  TabBarPresenter.swift
//  News
//
//  Created by Nikita Teplyakov on 15/05/2020.
//  Copyright © 2020 Nikita Teplyakov. All rights reserved.
//

class TabBarPresenter {

    // MARK: - Properties
    
    weak var delegate: TabBarPresenterDelegate?

    private let interactor: TabBarInteractorProtocol
    private let router: TabBarRouterProtocol

    // MARK: - Construction

    init(interactor: TabBarInteractorProtocol, router: TabBarRouterProtocol) {
        self.interactor = interactor
        self.router = router
    }
}

// MARK: - TabBarPresenterProtocol

extension TabBarPresenter: TabBarPresenterProtocol {

}

// MARK: - TabBarInteractorDelegate

extension TabBarPresenter: TabBarInteractorDelegate {

}