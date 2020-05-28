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

	private let userDefaults: UserDefaults
	private let readNewsUserDefaultsKey = "readNewsKey"
	private var readNewsLinksCache: [String] {
		get {
			UserDefaults.standard.value(forKey: readNewsUserDefaultsKey) as? [String] ?? []
		}
		set {
			UserDefaults.standard.set(newValue, forKey: readNewsUserDefaultsKey)
		}
	}

	// MARK: - Construction

	public init(userDefaults: UserDefaults = UserDefaults.standard) {
		self.userDefaults = userDefaults
	}

	// MARK: - Private Methods

	private func setupNotificationToken() {
		do {
			notificationToken = try Realm().objects(NewsObject.self)
				.observe { [weak self] changes in
					switch changes {
					case .initial(let results):
						self?.notifyDelegate(results)
					case .update(let results, _, _, _):
						self?.notifyDelegate(results)
					case .error(let error):
						print(error.localizedDescription)
					}
				}
		} catch {
			print(error.localizedDescription)
		}
	}

	private func notifyDelegate(_ results: Results<NewsObject>) {
		let news: Array<NewsDTO> = results.map { self.dtoFromObject($0) }
		delegate?.saveService(self, didUpdateNews: news)
	}

	// MARK: - Mapping

	private func dtoFromObject(_ object: NewsObject) -> NewsDTO {
		return NewsDTO(source: object.source,
					   link: object.link,
					   date: object.date,
					   title: object.title,
					   imageLink: object.imageLink,
					   description: object.shortDescription)
	}

	private func objectFromDTO(_ dto: NewsDTO) -> NewsObject {
		let object = NewsObject()
		object.source = dto.source
		object.link = dto.link
		object.date = dto.date
		object.title = dto.title
		object.imageLink = dto.imageLink
		object.shortDescription = dto.description

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
				guard let self = self else { return }

				do {
					let realm = try Realm()
					let results = realm.objects(NewsObject.self)
					let news: [NewsDTO] = results.map {
						self.dtoFromObject($0)
					}

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

					let realm = try Realm()

					let links = Set(news.map({ $0.link }))

					let realmObjects = realm.objects(NewsObject.self)
					let objectsToSave = news.map { self.objectFromDTO($0) }
					let objectsToDelete = realmObjects.filter { !links.contains($0.link) }

					try realm.write {
						realm.add(objectsToSave, update: .modified)
						realm.delete(objectsToDelete)
					}

					DispatchQueue.main.async {
						let readLinks = self.readNewsLinks()
						let intersection = readLinks.intersection(links)

						if readLinks.count != intersection.count {
							self.readNewsLinksCache = Array(intersection)
						}
					}

					safeCompletion(.success(()))
				} catch {
					safeCompletion(.failure(error))
				}
			}
		}
	}

	public func readNewsLinks() -> Set<String> {
		return Set(readNewsLinksCache)
	}

	public func saveReadNewsLink(_ link: String) {
		var links = readNewsLinks()

		if !links.contains(link) {
			links.insert(link)
			readNewsLinksCache = Array(links)
		}
	}
}
