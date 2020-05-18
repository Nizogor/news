//
//  TabBarRouter.swift
//  News
//
//  Created by Nikita Teplyakov on 15/05/2020.
//  Copyright © 2020 Nikita Teplyakov. All rights reserved.
//

import UIKit

class TabBarRouter {

    // MARK: - Properties

	weak var viewController: UITabBarController? {
		didSet { setupViewControllers() }
	}

	// MARK: - Private Properties

	private let newsListBuilder: NewsListBuilder

	// MARK: - Construction

	init(newsListBuilder: NewsListBuilder) {
		self.newsListBuilder = newsListBuilder
	}

	// MARK: - Private Methods

	private func setupViewControllers() {
		let newsListViewController = newsListBuilder.buildModule()
		let newsListNavigationController = UINavigationController(rootViewController: newsListViewController)

		viewController?.setViewControllers([newsListNavigationController], animated: false)
	}
}

extension TabBarRouter: TabBarRouterProtocol {

}
