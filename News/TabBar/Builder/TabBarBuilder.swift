//
//  TabBarBuilder.swift
//  News
//
//  Created by Nikita Teplyakov on 15/05/2020.
//  Copyright © 2020 Nikita Teplyakov. All rights reserved.
//

import UIKit

class TabBarBuilder {

    // MARK: - Methods
    
    func buildModule() -> UIViewController {
        let interactor = TabBarInteractor()
        let router = TabBarRouter()

        let presenter = TabBarPresenter(interactor: interactor, router: router)
        let viewController = TabBarViewController(presenter: presenter)

        interactor.delegate = presenter
        presenter.delegate = viewController
        router.viewController = viewController

        return viewController
    }
}
