//
//  SettingsServiceProtocol.swift
//  NewsKit
//
//  Created by Nikita Teplyakov on 18.05.2020.
//  Copyright © 2020 Nikita Teplyakov. All rights reserved.
//

public protocol SettingsProviderDelegate: class {
	func settingsService(_ settingsService: SettingsServiceProtocol, didChangeUpdatePeriod updatePeriod: TimeInterval)
	func settingsService(_ settingsService: SettingsServiceProtocol, didChangeShowingSourcePolicy shouldShowSource: Bool)
}

public protocol SettingsProviderProtocol {
	var updatePeriod: TimeInterval { get }
	var shouldShowSource: Bool { get }

	func addDelegate(_ delegate: SettingsProviderDelegate)
	func removeDelegate(_ delegate: SettingsProviderDelegate)
}

public protocol SettingsServiceProtocol: SettingsProviderProtocol {
	var updatePeriod: TimeInterval { get set }
	var shouldShowSource: Bool { get set }
}
