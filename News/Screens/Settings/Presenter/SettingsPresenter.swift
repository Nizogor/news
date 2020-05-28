//
//  SettingsPresenter.swift
//  News
//
//  Created by Nikita Teplyakov on 28/05/2020.
//  Copyright © 2020 Nikita Teplyakov. All rights reserved.
//

import NewsKit

class SettingsPresenter {

    // MARK: - Properties
    
    weak var delegate: SettingsPresenterDelegate?

    // MARK: - Private Properties

    private let interactor: SettingsInteractorProtocol
    private let router: SettingsRouterProtocol

	private let sources: [NewsSource]
	private let settingsService: SettingsServiceProtocol
	private let updateTimeViewModel: UpdateTimeSettingsViewModelProtocol

	private var sourcesListSettingsModels: [SourcesListSettingsModel] {
		didSet { delegate?.reloadSettingsList() }
	}

    // MARK: - Construction

    init(interactor: SettingsInteractorProtocol,
		 router: SettingsRouterProtocol,
		 sourcesProvider: NewsSourcesProviderProtocol,
		 settingsService: SettingsServiceProtocol,
		 updateTimeViewModel: UpdateTimeSettingsViewModelProtocol) {
        self.interactor = interactor
        self.router = router
		self.sources = sourcesProvider.fetchNewsSources().sorted { $0.name < $1.name }
		self.settingsService = settingsService
		self.updateTimeViewModel = updateTimeViewModel

		let disabledSources = settingsService.disabledNewsSources
		sourcesListSettingsModels = sources.map {
			SourcesListSettingsModel(isOn: !disabledSources.contains($0.link), title: $0.name)
		}
    }
}

// MARK: - SettingsPresenterProtocol

extension SettingsPresenter: SettingsPresenterProtocol {

	var sections: [SettingsSection] {
		return [SettingsSection.updateTime(title: "Update period", viewModel: updateTimeViewModel),
				SettingsSection.newsSources(title: "News sources", sources: sourcesListSettingsModels)]
	}

	func selectSourceAtIndex(_ index: Int) {
		let source = sources[index]

		var disabledSources = settingsService.disabledNewsSources

		if disabledSources.contains(source.link) {
			disabledSources.remove(source.link)
		} else {
			disabledSources.insert(source.link)
		}

		settingsService.disabledNewsSources = disabledSources
		sourcesListSettingsModels = sources.map {
			SourcesListSettingsModel(isOn: !disabledSources.contains($0.link), title: $0.name)
		}
	}
}

// MARK: - SettingsInteractorDelegate

extension SettingsPresenter: SettingsInteractorDelegate {

}
