//
//  WebPresenter.swift
//  News
//
//  Created by Nikita Teplyakov on 26/05/2020.
//  Copyright © 2020 Nikita Teplyakov. All rights reserved.
//

class WebPresenter {

    // MARK: - Properties
    
    weak var delegate: WebPresenterDelegate?

    // MARK: - Private Properties

    private let interactor: WebInteractorProtocol
    private let router: WebRouterProtocol

    // MARK: - Construction

    init(interactor: WebInteractorProtocol, router: WebRouterProtocol) {
        self.interactor = interactor
        self.router = router
    }
}

// MARK: - WebPresenterProtocol

extension WebPresenter: WebPresenterProtocol {

}

// MARK: - WebInteractorDelegate

extension WebPresenter: WebInteractorDelegate {

}