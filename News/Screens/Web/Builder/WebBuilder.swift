//
//  WebBuilder.swift
//  News
//
//  Created by Nikita Teplyakov on 26/05/2020.
//  Copyright © 2020 Nikita Teplyakov. All rights reserved.
//

import UIKit

class WebBuilder {

    // MARK: - Methods
    
    func buildModule() -> UIViewController {
        let interactor = WebInteractor()
        let router = WebRouter()

        let presenter = WebPresenter(interactor: interactor, router: router)
        let viewController = WebViewController(presenter: presenter)

        interactor.delegate = presenter
        presenter.delegate = viewController
        router.viewController = viewController

        return viewController
    }
}
