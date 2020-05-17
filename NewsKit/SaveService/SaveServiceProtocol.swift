//
//  SaveServiceProtocol.swift
//  NewsKit
//
//  Created by Nikita Teplyakov on 16.05.2020.
//  Copyright © 2020 Nikita Teplyakov. All rights reserved.
//

public protocol SaveServiceDelegate: class {
	func saveService(_ saveService: SaveServiceProtocol, didUpdateNews news: [NewsDTO])
}

public protocol SaveServiceProtocol: class {
	var delegate: SaveServiceDelegate? { get set }

	func fetchNews(completion: @escaping (Result<[NewsDTO], Error>) -> ())
	func saveNews(_ news: [NewsDTO], completion: @escaping (Result<Void, Error>) -> ())
}

extension SaveServiceProtocol {
	func saveNews(_ news: [NewsDTO]) {
		saveNews(news, completion: { _ in

		})
	}
}
