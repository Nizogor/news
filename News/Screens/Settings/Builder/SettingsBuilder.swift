//
//  SettingsBuilder.swift
//  News
//
//  Created by Nikita Teplyakov on 28/05/2020.
//  Copyright © 2020 Nikita Teplyakov. All rights reserved.
//

import UIKit

class SettingsBuilder {

	// MARK: - Private Properties

	private let dependencyContainer: SettingsDependencyContainer

	// MARK: - Construction

	init(dependencyContainer: SettingsDependencyContainer) {
		self.dependencyContainer = dependencyContainer
	}

    // MARK: - Methods
    
	func buildModule() -> UIViewController {
        let interactor = SettingsInteractor()
        let router = SettingsRouter()

        let presenter = SettingsPresenter(interactor: interactor, router: router)
        let viewController = SettingsViewController(presenter: presenter)

        interactor.delegate = presenter
        presenter.delegate = viewController
        router.viewController = viewController

        return viewController
    }
}
