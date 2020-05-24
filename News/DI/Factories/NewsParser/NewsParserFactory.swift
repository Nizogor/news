//
//  NewsParserFactory.swift
//  News
//
//  Created by Nikita Teplyakov on 23.05.2020.
//  Copyright © 2020 Nikita Teplyakov. All rights reserved.
//

import NewsKit

class NewsParserFactory {

}

extension NewsParserFactory: NewsParserFactoryProtocol {
	func makeNewsParser(data: Data) -> NewsParserProtocol {
		return NewsParser(data: data)
	}
}
