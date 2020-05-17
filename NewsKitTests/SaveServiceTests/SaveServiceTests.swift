//
//  SaveServiceTests.swift
//  NewsKitTests
//
//  Created by Nikita Teplyakov on 17.05.2020.
//  Copyright © 2020 Nikita Teplyakov. All rights reserved.
//

import XCTest
@testable import NewsKit
import RealmSwift

class SaveServiceTests: XCTestCase {

	var onNewsUpdate: (([NewsDTO]) -> ())?

    override func setUp() {
		Realm.Configuration.defaultConfiguration.inMemoryIdentifier = "SaveServiceTests"

		do {
			let realm = try Realm()
			try realm.write {
				realm.deleteAll()
			}
		} catch {
			XCTFail(error.localizedDescription)
		}
    }

    override func tearDown() {

    }

	func test_savesNews() {
		let sut = SaveService()
		let newsToSave = randomNews(count: 2)
		let saveExpectation = XCTestExpectation()
		let saveWaiter = XCTWaiter()

		sut.saveNews(newsToSave) { result in
			saveExpectation.fulfill()
		}

		saveWaiter.wait(for: [saveExpectation], timeout: 3)

		let fetchExpectation = XCTestExpectation()

		sut.fetchNews { result in
			switch result {
			case .success(let fetchedNews):
				XCTAssertEqual(newsToSave.count, fetchedNews.count)
			case .failure(let error):
				XCTFail(error.localizedDescription)
			}

			fetchExpectation.fulfill()
		}

		let fetchWaiter = XCTWaiter()
		fetchWaiter.wait(for: [fetchExpectation], timeout: 3)

		XCTAssertFalse(saveWaiter.fulfilledExpectations.isEmpty)
		XCTAssertFalse(fetchWaiter.fulfilledExpectations.isEmpty)
	}

	func test_notificatesDelegate() {
		let sut = SaveService()
		sut.delegate = self

		let subscribeNotificationExpectation = XCTestExpectation()

		onNewsUpdate = { _ in
			subscribeNotificationExpectation.fulfill()
		}

		let subscribeNotificationWaiter = XCTWaiter()
		subscribeNotificationWaiter.wait(for: [subscribeNotificationExpectation], timeout: 3)

		let newsToSave = randomNews(count: 2)
		let saveNotificationExpectation = XCTestExpectation()

		onNewsUpdate = { savedNews in
			XCTAssertEqual(newsToSave.count, savedNews.count)
			saveNotificationExpectation.fulfill()
		}

		sut.saveNews(newsToSave)

		let saveNotificationWaiter = XCTWaiter()
		saveNotificationWaiter.wait(for: [saveNotificationExpectation], timeout: 3)

		XCTAssertFalse(subscribeNotificationWaiter.fulfilledExpectations.isEmpty)
		XCTAssertFalse(saveNotificationWaiter.fulfilledExpectations.isEmpty)
	}

	func test_overridesNews() {
		let sut = SaveService()

		let newsToSave = randomNews(count: 2)
		let firstSaveExpectation = XCTestExpectation()

		sut.saveNews(newsToSave) { _ in
			firstSaveExpectation.fulfill()
		}

		let firstSaveWaiter = XCTWaiter()
		firstSaveWaiter.wait(for: [firstSaveExpectation], timeout: 3)

		let secondSaveExpectation = XCTestExpectation()

		sut.saveNews(newsToSave) { _ in
			secondSaveExpectation.fulfill()
		}

		let secondSaveWaiter = XCTWaiter()
		secondSaveWaiter.wait(for: [secondSaveExpectation], timeout: 3)

		let fetchExpectation = XCTestExpectation()

		sut.fetchNews { result in
			switch result {
			case .success(let fetchedNews):
				XCTAssertEqual(newsToSave.count, fetchedNews.count)
			case .failure(let error):
				XCTFail(error.localizedDescription)
			}

			fetchExpectation.fulfill()
		}

		let fetchWaiter = XCTWaiter()
		fetchWaiter.wait(for: [fetchExpectation], timeout: 3)

		XCTAssertFalse(firstSaveWaiter.fulfilledExpectations.isEmpty)
		XCTAssertFalse(secondSaveWaiter.fulfilledExpectations.isEmpty)
		XCTAssertFalse(fetchWaiter.fulfilledExpectations.isEmpty)
	}

	// MARK: - Help Methods

	func randomNews(count: Int) -> [NewsDTO] {
		var result = [NewsDTO]()

		for _ in 0..<count {
			result.append(randomNews())
		}

		return result
	}

	func randomNews() -> NewsDTO {
		let time = Double(arc4random_uniform(1000))
		let date = Date(timeIntervalSinceNow: -time)

		return NewsDTO(source: UUID().uuidString,
					   link: UUID().uuidString,
					   date: date.description,
					   title: UUID().uuidString,
					   imageLink: UUID().uuidString,
					   description: UUID().uuidString)
	}
}

extension SaveServiceTests: SaveServiceDelegate {
	func saveService(_ saveService: SaveServiceProtocol, didUpdateNews news: [NewsDTO]) {
		onNewsUpdate?(news)
	}
}
