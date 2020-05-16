//
//  NewsParserTests.swift
//  NewsKitTests
//
//  Created by Nikita Teplyakov on 16.05.2020.
//  Copyright © 2020 Nikita Teplyakov. All rights reserved.
//

import XCTest
@testable import NewsKit

class NewsParserTests: XCTestCase {

	var mockData: Data? {
		guard let path = Bundle(for: Self.self).path(forResource: "MockRSS", ofType: "xml") else {
			return nil
		}

		return FileManager.default.contents(atPath: path)
	}

    override func setUp() {

    }

    override func tearDown() {

    }

    func test_setsDelegate() {
		let data = Data()
		let sut = NewsParser(data: data)

		XCTAssertNotNil(sut.delegate)
    }

	func test_throwsError_whenDataIsWrong() {
		let data = Data()
		let sut = NewsParser(data: data)
		let expectation = XCTestExpectation()

		let waiter = XCTWaiter()

		sut.fetchNews { result in
			switch result {
			case .success:
				XCTFail()
			default:
				break
			}

			expectation.fulfill()
		}

		waiter.wait(for: [expectation], timeout: 3)

		XCTAssertFalse(waiter.fulfilledExpectations.isEmpty)
	}

	func test_fetchesNews() {
		guard let data = mockData else {
			XCTFail()
			return
		}

		let sut = NewsParser(data: data)
		let expectation = XCTestExpectation()
		let waiter = XCTWaiter()

		sut.fetchNews { result in
			do {
				let items = try result.get()

				let title = "Крым смягчит ограничения из-за коронавируса с 18 мая"
				let link = "https://www.gazeta.ru/social/news/2020/05/16/n_14426995.shtml"
				let pubDate = "Sat, 16 May 2020 12:12:36 +0300"
				let description = "Глава республики Сергея Аксенова внес изменения в свой указ \"О введении режима повышенной готовности\" на территории Крыма. Ранее, с 12 мая, на полуострове вели \"масочный режим\", а с 18 мая планируется увеличение списка ..."
				let enclosure = "https://img.gazeta.ru/files3/372/12830372/RIAN_2525701.HR-pic905-895x505-18276.jpg"

				XCTAssertEqual(items.last?.title, title)
				XCTAssertEqual(items.last?.link, link)
				XCTAssertEqual(items.last?.pubDate, pubDate)
				XCTAssertEqual(items.last?.description, description)
				XCTAssertEqual(items.last?.enclosure, enclosure)
			} catch {
				XCTFail(error.localizedDescription)
			}

			expectation.fulfill()
		}

		waiter.wait(for: [expectation], timeout: 3)
		XCTAssertFalse(waiter.fulfilledExpectations.isEmpty)
	}
}
