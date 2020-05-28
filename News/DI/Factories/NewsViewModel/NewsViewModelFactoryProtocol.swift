//
//  NewsViewModelFactoryProtocol.swift
//  News
//
//  Created by Nikita Teplyakov on 18.05.2020.
//  Copyright © 2020 Nikita Teplyakov. All rights reserved.
//

protocol NewsViewModelFactoryProtocol {
	func makeNewsViewModel(news: News,
						   isRead: Bool,
						   isOpen: Bool) -> NewsPresenterViewModelProtocol
}
