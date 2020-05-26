//
//  WebViewController.swift
//  News
//
//  Created by Nikita Teplyakov on 26/05/2020.
//  Copyright © 2020 Nikita Teplyakov. All rights reserved.
//

import UIKit

class WebViewController: UIViewController {

    // MARK: - Private Properties

    private let presenter: WebPresenterProtocol

    // MARK: - Construction

    required init(presenter: WebPresenterProtocol) {
        self.presenter = presenter

        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - View Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

// MARK: - WebPresenterDelegate

extension WebViewController: WebPresenterDelegate {

}
