//
//  NewsViewModelProtocol.swift
//  News
//
//  Created by Nikita Teplyakov on 18.05.2020.
//  Copyright © 2020 Nikita Teplyakov. All rights reserved.
//

import Foundation

protocol NewsViewModelDelegate: class {
	func update()
}

protocol NewsViewModelProtocol {

	var delegate: NewsViewModelDelegate? { get set }

	var isLoading: Bool { get }
	var isRead: Bool { get }
	var shouldShowSource: Bool { get }
	var source: String { get }
	var date: String { get }
	var title: String { get }
	var imageData: Data? { get }
	var description: String { get }
}
