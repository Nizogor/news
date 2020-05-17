//
//  SaveService.swift
//  NewsKit
//
//  Created by Nikita Teplyakov on 16.05.2020.
//  Copyright © 2020 Nikita Teplyakov. All rights reserved.
//

import RealmSwift

public class SaveService {

	// MARK: - Properties

	public weak var delegate: SaveServiceDelegate? {
		didSet { setupNotificationToken() }
	}

	// MARK: - Private Properties

	private let queue = DispatchQueue(label: "com.NewsKit.SaveService", qos: .userInitiated)

	private var notificationToken: NotificationToken?

	// MARK: - Construction

	public init() {}

	// MARK: - Private Methods

	private func setupNotificationToken() {
		queue.async { [weak self] in
			autoreleasepool {
				do {
					guard let self = self else { return }

					self.notificationToken = try Realm().objects(NewsObject.self)
						.observe(on: self.queue, { [weak self] changes in
							switch changes {
							case .initial(let results):
								self?.notifyDelegate(results)
							case .update(let results, _, _, _):
								self?.notifyDelegate(results)
							case .error(let error):
								print(error.localizedDescription)
							}
						})
				} catch {
					print(error.localizedDescription)
				}
			}
		}
	}

	private func notifyDelegate(_ results: Results<NewsObject>) {
		let news: Array<NewsDTO> = results.map { self.map($0) }

		DispatchQueue.main.async { [weak self] in
			if let self = self {
				self.delegate?.saveService(self, didUpdateNews: news)
			}
		}
	}

	// MARK: - Mapping

	private func map(_ object: NewsObject) -> NewsDTO {
		return NewsDTO(source: object.source,
					   link: object.link,
					   date: object.date,
					   title: object.title,
					   imageLink: object.imageLink,
					   description: object.shortDescription)
	}

	private func map(_ news: NewsDTO) -> NewsObject {
		let object = NewsObject()
		object.source = news.source
		object.link = news.link
		object.date = news.date
		object.title = news.title
		object.imageLink = news.imageLink
		object.shortDescription = news.description

		return object
	}
}

extension SaveService: SaveServiceProtocol {

	public func fetchNews(completion: @escaping (Result<[NewsDTO], Error>) -> ()) {
		let safeCompletion = { result in
			DispatchQueue.main.async {
				completion(result)
			}
		}

		autoreleasepool {
			queue.async { [weak self] in
				do {
					guard let self = self else { return }

					let aRealm = try Realm()
					let results = aRealm.objects(NewsObject.self)
					let news: Array<NewsDTO> = results.map { self.map($0) }

					safeCompletion(.success(news))
				} catch {
					safeCompletion(.failure(error))
				}
			}
		}
	}

	public func saveNews(_ news: [NewsDTO], completion: @escaping (Result<Void, Error>) -> ()) {
		let safeCompletion = { result in
			DispatchQueue.main.async {
				completion(result)
			}
		}

		autoreleasepool {
			queue.async { [weak self] in
				do {
					guard let self = self else { return }

					let aRealm = try Realm()
					let objects = news.map { self.map($0) }

					try aRealm.write {
						aRealm.deleteAll()
						aRealm.add(objects)
					}

					safeCompletion(.success(()))
				} catch {
					safeCompletion(.failure(error))
				}
			}
		}
	}
}
