//
//  NewsListViewController.swift
//  News
//
//  Created by Nikita Teplyakov on 18/05/2020.
//  Copyright © 2020 Nikita Teplyakov. All rights reserved.
//

import UIKit

class NewsListViewController: UIViewController {

    // MARK: - Private Properties

    private let presenter: NewsListPresenterProtocol

	private let screenName = "News"

    // MARK: - Construction

    required init(presenter: NewsListPresenterProtocol) {
        self.presenter = presenter

        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - View Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()

		setupNavigationItem()
		setupTabBarItem()
    }

	// MARK: - Private Methods

	private func setupNavigationItem() {
		title = screenName
	}

	private func setupTabBarItem() {
		tabBarItem = UITabBarItem(title: screenName, image: #imageLiteral(resourceName: "news_gray"), selectedImage: #imageLiteral(resourceName: "news_black"))
	}
}

// MARK: - NewsListPresenterDelegate

extension NewsListViewController: NewsListPresenterDelegate {
	func updateNewsList() {
		
	}
}
