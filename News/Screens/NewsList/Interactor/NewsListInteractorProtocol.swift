//
//  NewsListInteractorProtocol.swift
//  News
//
//  Created by Nikita Teplyakov on 18/05/2020.
//  Copyright © 2020 Nikita Teplyakov. All rights reserved.
//

import NewsKit

protocol NewsListInteractorProtocol {

	var isLoading: Bool { get }
	var readNewsLinks: Set<String> { get }

	func addReadNewsLink(_ link: String)
	func updateNews(from newsSources: [NewsSource])
}
