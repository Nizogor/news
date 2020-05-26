//
//  NewsListRouterProtocol.swift
//  News
//
//  Created by Nikita Teplyakov on 18/05/2020.
//  Copyright © 2020 Nikita Teplyakov. All rights reserved.
//

import Foundation

protocol NewsListRouterProtocol {
	func openNews(title: String, urlRequest: URLRequest)
	func showWrongUrlError()
}
