//
//  SettingsPresenter.swift
//  News
//
//  Created by Nikita Teplyakov on 28/05/2020.
//  Copyright © 2020 Nikita Teplyakov. All rights reserved.
//

class SettingsPresenter {

    // MARK: - Properties
    
    weak var delegate: SettingsPresenterDelegate?

    // MARK: - Private Properties

    private let interactor: SettingsInteractorProtocol
    private let router: SettingsRouterProtocol

    // MARK: - Construction

    init(interactor: SettingsInteractorProtocol, router: SettingsRouterProtocol) {
        self.interactor = interactor
        self.router = router
    }
}

// MARK: - SettingsPresenterProtocol

extension SettingsPresenter: SettingsPresenterProtocol {

}

// MARK: - SettingsInteractorDelegate

extension SettingsPresenter: SettingsInteractorDelegate {

}