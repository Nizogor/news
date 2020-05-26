//
//  NewsPresenterViewModelProtocol.swift
//  News
//
//  Created by Nikita Teplyakov on 18.05.2020.
//  Copyright © 2020 Nikita Teplyakov. All rights reserved.
//

import Foundation

protocol NewsViewModelDelegate: class {
	func viewModelDidUpdate(shouldShowSource: Bool)
	func viewModelDidUpdate(isRead: Bool)
	func viewModelDidUpdate(isOpen: Bool)
	func viewModelDidUpdate(isLoading: Bool)
	func viewModelDidUpdateImage()
}

protocol NewsPresenterViewModelProtocol: NewsViewModelProtocol {
	var isRead: Bool { get set }
	var shouldShowSource: Bool { get set }
	var isOpen: Bool { get set }
	var link: String { get }
}

protocol NewsViewModelProtocol: class {

	var delegate: NewsViewModelDelegate? { get set }

	var isLoading: Bool { get }
	var isRead: Bool { get }
	var shouldShowSource: Bool { get }
	var isOpen: Bool { get }
	var source: String { get }
	var date: String { get }
	var title: String { get }
	var imageData: Data? { get }
	var description: String { get }

	func detailsButtonTap()
}
