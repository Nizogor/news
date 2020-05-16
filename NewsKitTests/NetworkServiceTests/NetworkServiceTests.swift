//
//  NetworkServiceTests.swift
//  NewsKitTests
//
//  Created by Nikita Teplyakov on 16.05.2020.
//  Copyright © 2020 Nikita Teplyakov. All rights reserved.
//

import XCTest
@testable import NewsKit

class NetworkServiceTests: XCTestCase {

	let sut = NetworkService()
	let expectation = XCTestExpectation()
	let waiter = XCTWaiter()

	func test_downloadsData() {
		sut.downloadNews(urlString: "https://www.gazeta.ru/export/rss/lenta.xml") { [weak self] result in
			switch result {
			case .failure(let error):
				XCTFail(error.localizedDescription)
			default:
				break
			}

			self?.expectation.fulfill()
		}

		waiter.wait(for: [expectation], timeout: 3)

		XCTAssertFalse(waiter.fulfilledExpectations.isEmpty)
	}

	func test_fails_whenWrongURLStringPassed() {
		sut.downloadNews(urlString: "wrong url") { [weak self] result in
			switch result {
			case .success:
				XCTFail()
			default:
				break
			}

			self?.expectation.fulfill()
		}

		waiter.wait(for: [expectation], timeout: 3)

		XCTAssertFalse(waiter.fulfilledExpectations.isEmpty)
	}
}
