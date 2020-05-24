//
//  NewsSourcesProviderTests.swift
//  NewsKitTests
//
//  Created by Nikita Teplyakov on 24.05.2020.
//  Copyright © 2020 Nikita Teplyakov. All rights reserved.
//

import XCTest
@testable import NewsKit

class NewsSourcesProviderTests: XCTestCase {

	func testFetchesNewsSources() {
		let sut = NewsSourcesProvider()
		let newsSources = sut.fetchNewsSources()

		XCTAssertFalse(newsSources.isEmpty)
	}
}
