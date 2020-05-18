//
//  SettingsService.swift
//  NewsKit
//
//  Created by Nikita Teplyakov on 18.05.2020.
//  Copyright © 2020 Nikita Teplyakov. All rights reserved.
//

private class SettingsServiceDelegateWrapper {
	weak var delegate: SettingsServiceDelegate?
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
		set {
			userDefaults.set(newValue, forKey: updatePeriodUserDefaultsKey)
			delegateWrappers.forEach { $0.delegate?.settingsService(self, didChangeUpdatePeriod: newValue) }
		}
		get {
			userDefaults.value(forKey: updatePeriodUserDefaultsKey) as? TimeInterval ?? defaultUpdatePeriod
		}
	}

	public var shouldShowSource: Bool {
		set {
			userDefaults.set(newValue, forKey: shouldShowSourceUserDefaultsKey)
			delegateWrappers.forEach { $0.delegate?.settingsService(self, didChangeShowingSourcePolicy: newValue) }
		}
		get {
			userDefaults.value(forKey: shouldShowSourceUserDefaultsKey) as? Bool ?? shouldShowSourceByDefault
		}
	}

	public func addDelegate(_ delegate: SettingsServiceDelegate) {
		let wrapper = SettingsServiceDelegateWrapper()
		wrapper.delegate = delegate

		delegateWrappers.append(wrapper)
	}

	public func removeDelegate(_ delegate: SettingsServiceDelegate) {
		delegateWrappers.removeAll { $0.delegate === delegate }
	}
}
