//
//  SettingsService.swift
//  NewsKit
//
//  Created by Nikita Teplyakov on 18.05.2020.
//  Copyright © 2020 Nikita Teplyakov. All rights reserved.
//

private class SettingsServiceDelegateWrapper {
	weak var delegate: SettingsProviderDelegate?
}

public class SettingsService {

	// MARK: - Private Properties

	private var delegateWrappers = [SettingsServiceDelegateWrapper]()

	private let userDefaults: UserDefaults

	private let defaultUpdatePeriod = TimeInterval(30)
	private let shouldShowSourceByDefault = true

	private let updatePeriodUserDefaultsKey = "updatePeriodKey"
	private let shouldShowSourceUserDefaultsKey = "shouldShowSourceKey"

	// MARK: - Construction

	public init(userDefaults: UserDefaults = UserDefaults.standard) {
		self.userDefaults = userDefaults
	}
}

extension SettingsService: SettingsServiceProtocol {

	public var updatePeriod: TimeInterval {
		get {
			userDefaults.value(forKey: updatePeriodUserDefaultsKey) as? TimeInterval ?? defaultUpdatePeriod
		}
		set {
			userDefaults.set(newValue, forKey: updatePeriodUserDefaultsKey)
			delegateWrappers.forEach { $0.delegate?.settingsService(self, didChangeUpdatePeriod: newValue) }
		}
	}

	public var shouldShowSource: Bool {
		get {
			userDefaults.value(forKey: shouldShowSourceUserDefaultsKey) as? Bool ?? shouldShowSourceByDefault
		}
		set {
			userDefaults.set(newValue, forKey: shouldShowSourceUserDefaultsKey)
			delegateWrappers.forEach { $0.delegate?.settingsService(self, didChangeShowingSourcePolicy: newValue) }
		}
	}

	public func addDelegate(_ delegate: SettingsProviderDelegate) {
		let wrapper = SettingsServiceDelegateWrapper()
		wrapper.delegate = delegate

		delegateWrappers.append(wrapper)
	}

	public func removeDelegate(_ delegate: SettingsProviderDelegate) {
		delegateWrappers.removeAll { $0.delegate === delegate }
	}
}
