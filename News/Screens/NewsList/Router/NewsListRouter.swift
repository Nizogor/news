//
//  NewsListRouter.swift
//  News
//
//  Created by Nikita Teplyakov on 18/05/2020.
//  Copyright © 2020 Nikita Teplyakov. All rights reserved.
//

import UIKit

class NewsListRouter {

    // MARK: - Properties

	weak var viewController: UIViewController?

	// MARK: - Private Properties

	private let webBuilder: WebBuilder

	// MARK: - Construction

	init(webBuilder: WebBuilder) {
		self.webBuilder = webBuilder
	}
}

extension NewsListRouter: NewsListRouterProtocol {
	func openNews(title: String, urlRequest: URLRequest) {
		let webViewController = webBuilder.buildModule(title: title, urlRequest: urlRequest)
		viewController?.navigationController?.pushViewController(webViewController, animated: true)
	}

	func showWrongUrlError() {
		let action = UIAlertAction(title: "OK", style: .cancel)
		let alertController = UIAlertController(title: "Ошибка",
												message: "Не удалось открыть новость",
												preferredStyle: .alert)
		alertController.addAction(action)

		viewController?.present(alertController, animated: true)
	}
}
