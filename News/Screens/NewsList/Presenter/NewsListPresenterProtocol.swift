//
//  NewsListPresenterProtocol.swift
//  News
//
//  Created by Nikita Teplyakov on 18/05/2020.
//  Copyright © 2020 Nikita Teplyakov. All rights reserved.
//

protocol NewsListPresenterProtocol {
	var viewModelsCount: Int { get }

	func viewModelAtIndex(_ index: Int) -> NewsViewModelProtocol
	func selectViewAtIndex(_ index: Int)
}
