//
//  MockDependencyContainer.swift
//  NewsKitTests
//
//  Created by Nikita Teplyakov on 17.05.2020.
//  Copyright © 2020 Nikita Teplyakov. All rights reserved.
//

@testable import NewsKit

class MockDependencyContainer {

	func makeNetworkService() -> NetworkServiceProtocol {
		return NetworkService()
	}

	func makeParser(data: Data) -> NewsParserProtocol {
		return NewsParser(data: data)
	}
}
