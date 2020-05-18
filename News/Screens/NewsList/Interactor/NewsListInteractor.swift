//
//  NewsListInteractor.swift
//  News
//
//  Created by Nikita Teplyakov on 18/05/2020.
//  Copyright © 2020 Nikita Teplyakov. All rights reserved.
//

class NewsListInteractor {

    // MARK: - Properties

    weak var delegate: NewsListInteractorDelegate?
}

// MARK: - NewsListInteractorProtocol

extension NewsListInteractor: NewsListInteractorProtocol {

}
