//
//  WebPresenter.swift
//  News
//
//  Created by Nikita Teplyakov on 26/05/2020.
//  Copyright © 2020 Nikita Teplyakov. All rights reserved.
//

import Foundation

class WebPresenter {

    // MARK: - Properties
    
    weak var delegate: WebPresenterDelegate?

	let title: String
	let urlRequest: URLRequest

    // MARK: - Private Properties

    private let interactor: WebInteractorProtocol
    private let router: WebRouterProtocol

    // MARK: - Construction

    init(interactor: WebInteractorProtocol,
		 router: WebRouterProtocol,
		 title: String,
		 urlRequest: URLRequest) {
		self.title = title
        self.interactor = interactor
        self.router = router
		self.urlRequest = urlRequest
    }
}

// MARK: - WebPresenterProtocol

extension WebPresenter: WebPresenterProtocol {
	func requestPermissionForNavigationAction(with urlRequest: URLRequest) -> Bool {
		return self.urlRequest.url?.absoluteString == urlRequest.url?.absoluteString
	}
}

// MARK: - WebInteractorDelegate

extension WebPresenter: WebInteractorDelegate {

}
