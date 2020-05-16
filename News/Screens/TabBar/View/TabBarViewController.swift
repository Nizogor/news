//
//  TabBarViewController.swift
//  News
//
//  Created by Nikita Teplyakov on 15/05/2020.
//  Copyright © 2020 Nikita Teplyakov. All rights reserved.
//

import UIKit

class TabBarViewController: UITabBarController {

    // MARK: - Private Properties

    private let presenter: TabBarPresenterProtocol

    // MARK: - Construction

    required init(presenter: TabBarPresenterProtocol) {
        self.presenter = presenter

        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - View Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()

		setup()
    }

	// MARK: - Private Methods

	private func setup() {
		view.backgroundColor = .white
	}
}

// MARK: - TabBarPresenterDelegate

extension TabBarViewController: TabBarPresenterDelegate {

}
