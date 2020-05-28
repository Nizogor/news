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

	private let updatePeriodUserDefaultsKey = "updatePeriodKey"
	private let disabledNewsSourcesUserDefaultsKey = "disabledNewsSourcesKey"

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

	public var disabledNewsSources: Set<String> {
		get {
			let disabledSources = userDefaults.value(forKey: disabledNewsSourcesUserDefaultsKey) as? [String] ?? []
			return Set(disabledSources)
		}
		set {
			let array = Array(newValue)
			userDefaults.set(array, forKey: disabledNewsSourcesUserDefaultsKey)
			delegateWrappers.forEach { $0.delegate?.settingsService(self, didChangeDisabledNewsSources: newValue) }
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
