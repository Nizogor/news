//
//  NetworkServiceProtocol.swift
//  NewsKit
//
//  Created by Nikita Teplyakov on 16.05.2020.
//  Copyright © 2020 Nikita Teplyakov. All rights reserved.
//

public protocol NetworkServiceProtocol: class {
	func downloadNews(urlString: String, completion: @escaping (Result<Data, Error>) -> ())
}
