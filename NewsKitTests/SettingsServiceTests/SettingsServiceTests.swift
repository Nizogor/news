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
	let mockDisabledNewsSources = Set(arrayLiteral: "source1", "source2")

	var onUpdatePeriodChanged: ((TimeInterval) -> ())?
	var onShowingSourcePolicyChanged: ((Bool) -> ())?
	var onDisabledNewsSourcesChanged: ((Set<String>) -> ())?

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
		sut?.disabledNewsSources = mockDisabledNewsSources
		
		XCTAssertEqual(sut?.updatePeriod, mockUpdatePeriod)
		XCTAssertEqual(sut?.shouldShowSource, mockShouldShowSource)
		XCTAssertEqual(sut?.disabledNewsSources, mockDisabledNewsSources)
	}

	func test_notificatesDelegate() {
		let extpectation = XCTestExpectation()
		extpectation.expectedFulfillmentCount = 3

		onUpdatePeriodChanged = { [weak self] value in
			XCTAssertEqual(self?.mockUpdatePeriod, value)
			extpectation.fulfill()
		}

		onShowingSourcePolicyChanged = { [weak self] value in
			XCTAssertEqual(self?.mockShouldShowSource, value)
			extpectation.fulfill()
		}

		onDisabledNewsSourcesChanged = { [weak self] value in
			XCTAssertEqual(self?.mockDisabledNewsSources, value)
			extpectation.fulfill()
		}

		sut?.addDelegate(self)
		sut?.updatePeriod = mockUpdatePeriod
		sut?.shouldShowSource = mockShouldShowSource
		sut?.disabledNewsSources = mockDisabledNewsSources

		let waiter = XCTWaiter()
		waiter.wait(for: [extpectation], timeout: 3)
		XCTAssertEqual(waiter.fulfilledExpectations.count, 1)
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

	func settingsService(_ settingsService: SettingsServiceProtocol, didChangeDisabledNewsSources newsSources: Set<String>) {
		onDisabledNewsSourcesChanged?(newsSources)
	}
}
