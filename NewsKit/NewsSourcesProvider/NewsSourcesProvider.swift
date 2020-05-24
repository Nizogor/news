//
//  NewsSourcesProvider.swift
//  NewsKit
//
//  Created by Nikita Teplyakov on 24.05.2020.
//  Copyright © 2020 Nikita Teplyakov. All rights reserved.
//

public class NewsSourcesProvider {
	public init() {}
}

// MARK: - NewsSourcesProviderProtocol

extension NewsSourcesProvider: NewsSourcesProviderProtocol {
	public func fetchNewsSources() -> [NewsSource] {
		guard let path = Bundle(for: Self.self).path(forResource: "NewsSources", ofType: "json"),
			let data = FileManager.default.contents(atPath: path) else {
			return []
		}

		do {
			let newsSources = try JSONDecoder().decode(NewsSources.self, from: data)
			return newsSources.items
		} catch {
			print(error.localizedDescription)
			return []
		}
	}
}
