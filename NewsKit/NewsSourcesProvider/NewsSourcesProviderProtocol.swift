//
//  NewsSourcesProviderProtocol.swift
//  NewsKit
//
//  Created by Nikita Teplyakov on 24.05.2020.
//  Copyright © 2020 Nikita Teplyakov. All rights reserved.
//

public protocol NewsSourcesProviderProtocol {
	func fetchNewsSources() -> [NewsSource]
}
