//
//  SettingsServiceTests.swift
//  NewsKitTests
//
//  Created by Nikita Teplyakov on 18.05.2020.
//  Copyright © 2020 Nikita Teplyakov. All rights reserved.
//

import XCTest
@testable import NewsKit

class SettingsServiceTests: XCTestCase {

	let suiteName = "SettingsServiceTests"
	let mockUpdatePeriod = TimeInterval(100)
	let mockShouldShowSource = false

	var onUpdatePeriodChanged: ((TimeInterval) -> ())?
	var onShowingSourcePolicyChanged: ((Bool) -> ())?

	lazy var sut: SettingsService? = {
		guard let userDefaults = UserDefaults(suiteName: suiteName) else {
			XCTFail()
			return nil
		}

		return SettingsService(userDefaults: userDefaults)
	}()

    override func setUp() {
		UserDefaults().removePersistentDomain(forName: suiteName)
    }

    override func tearDown() {

    }

	func test_savesSettings() {
		sut?.updatePeriod = mockUpdatePeriod
		sut?.shouldShowSource = mockShouldShowSource
		
		XCTAssertEqual(sut?.updatePeriod, mockUpdatePeriod)
		XCTAssertEqual(sut?.shouldShowSource, mockShouldShowSource)
	}

	func test_notificatesDelegate() {
		onUpdatePeriodChanged = { [weak self] value in
			XCTAssertEqual(self?.mockUpdatePeriod, value)
		}

		onShowingSourcePolicyChanged = { [weak self] value in
			XCTAssertEqual(self?.mockShouldShowSource, value)
		}

		sut?.addDelegate(self)
		sut?.updatePeriod = mockUpdatePeriod
		sut?.shouldShowSource = mockShouldShowSource
	}

	func test_removesDelegate() {
		onUpdatePeriodChanged = { _ in
			XCTFail()
		}

		sut?.addDelegate(self)
		sut?.removeDelegate(self)
		sut?.updatePeriod = mockUpdatePeriod
	}
}

extension SettingsServiceTests: SettingsProviderDelegate {
	func settingsService(_ settingsService: SettingsServiceProtocol, didChangeUpdatePeriod updatePeriod: TimeInterval) {
		onUpdatePeriodChanged?(updatePeriod)
	}

	func settingsService(_ settingsService: SettingsServiceProtocol, didChangeShowingSourcePolicy shouldShowSource: Bool) {
		onShowingSourcePolicyChanged?(shouldShowSource)
	}
}
