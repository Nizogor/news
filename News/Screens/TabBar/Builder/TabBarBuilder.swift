//
//  TabBarBuilder.swift
//  News
//
//  Created by Nikita Teplyakov on 15/05/2020.
//  Copyright © 2020 Nikita Teplyakov. All rights reserved.
//

import UIKit

class TabBarBuilder {

	// MARK: - Private Properties

	private let dependencyContainer: TabBarDependencyContainer

	// MARK: - Construction

	init(dependencyContainer: TabBarDependencyContainer) {
		self.dependencyContainer = dependencyContainer
	}

    // MARK: - Methods
    
    func buildModule() -> UITabBarController {
		let newsListBuilder = dependencyContainer.makeNewsListBuilder()

        let interactor = TabBarInteractor()
		let router = TabBarRouter(newsListBuilder: newsListBuilder)

        let presenter = TabBarPresenter(interactor: interactor, router: router)
        let viewController = TabBarViewController(presenter: presenter)

        interactor.delegate = presenter
        presenter.delegate = viewController
        router.viewController = viewController

        return viewController
    }
}
