//
//  NewsDTO.swift
//  NewsKit
//
//  Created by Nikita Teplyakov on 16.05.2020.
//  Copyright © 2020 Nikita Teplyakov. All rights reserved.
//

public struct NewsDTO {
	public let source: String
	public let link: String
	public let date: String
	public let title: String
	public let imageLink: String?
	public let description: String

	public init(source: String,
				link: String,
				date: String,
				title: String,
				imageLink: String?,
				description: String) {
		self.source = source
		self.link = link
		self.date = date
		self.title = title
		self.imageLink = imageLink
		self.description = description
	}
}
