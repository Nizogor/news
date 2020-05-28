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
	private let settingsBuilder: SettingsBuilder

	// MARK: - Construction

	init(newsListBuilder: NewsListBuilder,
		 settingsBuilder: SettingsBuilder) {
		self.newsListBuilder = newsListBuilder
		self.settingsBuilder = settingsBuilder
	}

	// MARK: - Private Methods

	private func setupViewControllers() {
		let newsListViewController = newsListBuilder.buildModule()
		let newsListNavigationController = UINavigationController(rootViewController: newsListViewController)

		let settingsViewController = settingsBuilder.buildModule()
		let settingsNavigationController = UINavigationController(rootViewController: settingsViewController)

		viewController?.setViewControllers([newsListNavigationController, settingsNavigationController], animated: false)
	}
}

extension TabBarRouter: TabBarRouterProtocol {

}
