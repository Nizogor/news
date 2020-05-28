//
//  SettingsSection.swift
//  News
//
//  Created by Nikita Teplyakov on 28.05.2020.
//  Copyright © 2020 Nikita Teplyakov. All rights reserved.
//

enum SettingsSection {
	case updateTime(title: String, viewModel: UpdateTimeSettingsViewModelProtocol)
	case newsSources(title: String, sources: [SourcesListSettingsModel])
}
