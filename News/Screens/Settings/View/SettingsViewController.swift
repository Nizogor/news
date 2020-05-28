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

    // MARK: - Construction

    required init(presenter: SettingsPresenterProtocol) {
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

// MARK: - SettingsPresenterDelegate

extension SettingsViewController: SettingsPresenterDelegate {

}
