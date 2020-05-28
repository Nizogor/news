//
//  SettingsViewController.swift
//  News
//
//  Created by Nikita Teplyakov on 28/05/2020.
//  Copyright © 2020 Nikita Teplyakov. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    // MARK: - Private Properties

    private let presenter: SettingsPresenterProtocol

	private let screenName = "Settings"

    // MARK: - Construction

    required init(presenter: SettingsPresenterProtocol) {
        self.presenter = presenter

        super.init(nibName: nil, bundle: nil)

		tabBarItem = UITabBarItem(title: screenName, image: #imageLiteral(resourceName: "gear_gray"), selectedImage: #imageLiteral(resourceName: "gear_black"))
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - View Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()

		setupNavigationItem()
    }

	// MARK: - Private Methods

	private func setupNavigationItem() {
		navigationItem.title = screenName
	}
}

// MARK: - SettingsPresenterDelegate

extension SettingsViewController: SettingsPresenterDelegate {

}
