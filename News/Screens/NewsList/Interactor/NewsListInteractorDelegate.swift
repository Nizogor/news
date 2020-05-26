//
//  NewsListInteractorDelegate.swift
//  News
//
//  Created by Nikita Teplyakov on 18/05/2020.
//  Copyright © 2020 Nikita Teplyakov. All rights reserved.
//

protocol NewsListInteractorDelegate: class {
	func newsListInteractor(_ interactor: NewsListInteractorProtocol, didUpdateNews news: [News])
}
