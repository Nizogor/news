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

	private let updateTimeViewModel: UpdateTimeSettingsViewModelProtocol

    // MARK: - Construction

    init(interactor: SettingsInteractorProtocol, router: SettingsRouterProtocol,
		 updateTimeViewModel: UpdateTimeSettingsViewModelProtocol) {
        self.interactor = interactor
        self.router = router
		self.updateTimeViewModel = updateTimeViewModel
    }
}

// MARK: - SettingsPresenterProtocol

extension SettingsPresenter: SettingsPresenterProtocol {
	var sections: [SettingsSection] {
		return [SettingsSection.updateTime(title: "Update period", viewModel: updateTimeViewModel)]
	}
}

// MARK: - SettingsInteractorDelegate

extension SettingsPresenter: SettingsInteractorDelegate {

}
