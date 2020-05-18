//
//  NetworkService.swift
//  NewsKit
//
//  Created by Nikita Teplyakov on 16.05.2020.
//  Copyright © 2020 Nikita Teplyakov. All rights reserved.
//

import Alamofire

public class NetworkService {
	public init() {}
}

extension NetworkService: NetworkServiceProtocol {
	public func downloadResource(link: String, completion: @escaping (Result<Data, Error>) -> ()) {
		AF.request(link).responseData { response in
			do {
				let data = try response.result.get()
				completion(.success(data))
			} catch {
				completion(.failure(error))
			}
		}
	}
}
