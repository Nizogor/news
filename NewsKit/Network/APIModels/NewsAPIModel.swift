//
//  NewsAPIModel.swift
//  NewsKit
//
//  Created by Nikita Teplyakov on 16.05.2020.
//  Copyright © 2020 Nikita Teplyakov. All rights reserved.
//

public struct NewsAPIModel: Codable {
	public let link: String
	public let pubDate: String
	public let title: String
	public let enclosure: String?
	public let description: String
}
