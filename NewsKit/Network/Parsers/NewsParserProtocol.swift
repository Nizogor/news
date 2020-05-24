//
//  NewsParserProtocol.swift
//  NewsKit
//
//  Created by Nikita Teplyakov on 16.05.2020.
//  Copyright © 2020 Nikita Teplyakov. All rights reserved.
//

public protocol NewsParserProtocol {
	func fetchNews(completion: @escaping (Result<[NewsAPIModel], Error>) -> ())
}
