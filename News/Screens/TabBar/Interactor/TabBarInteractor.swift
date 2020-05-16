//
//  TabBarInteractor.swift
//  News
//
//  Created by Nikita Teplyakov on 15/05/2020.
//  Copyright © 2020 Nikita Teplyakov. All rights reserved.
//

class TabBarInteractor {

    // MARK: - Properties

    weak var delegate: TabBarInteractorDelegate?
}

// MARK: - TabBarInteractorProtocol

extension TabBarInteractor: TabBarInteractorProtocol {

}
