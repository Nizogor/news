//
//  WebInteractor.swift
//  News
//
//  Created by Nikita Teplyakov on 26/05/2020.
//  Copyright © 2020 Nikita Teplyakov. All rights reserved.
//

class WebInteractor {

    // MARK: - Properties

    weak var delegate: WebInteractorDelegate?
}

// MARK: - WebInteractorProtocol

extension WebInteractor: WebInteractorProtocol {

}
