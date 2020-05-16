//
//  NewsAPIModel.swift
//  NewsKit
//
//  Created by Nikita Teplyakov on 16.05.2020.
//  Copyright © 2020 Nikita Teplyakov. All rights reserved.
//

struct NewsAPIModel: Codable {
	let link: String
	let pubDate: String
	let title: String
	let enclosure: String?
	let description: String
}
