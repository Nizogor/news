//
//  NewsListBuilder.swift
//  News
//
//  Created by Nikita Teplyakov on 18/05/2020.
//  Copyright © 2020 Nikita Teplyakov. All rights reserved.
//

import UIKit

class NewsListBuilder {

    // MARK: - Methods
    
    func buildModule() -> UIViewController {
        let interactor = NewsListInteractor()
        let router = NewsListRouter()

        let presenter = NewsListPresenter(interactor: interactor, router: router)
        let viewController = NewsListViewController(presenter: presenter)

        interactor.delegate = presenter
        presenter.delegate = viewController
        router.viewController = viewController

        return viewController
    }
}
