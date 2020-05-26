//
//  NewsListViewController.swift
//  News
//
//  Created by Nikita Teplyakov on 18/05/2020.
//  Copyright © 2020 Nikita Teplyakov. All rights reserved.
//

import UIKit
import PureLayout

class NewsListViewController: UIViewController {

    // MARK: - Private Properties

    private let presenter: NewsListPresenterProtocol

	private let screenName = "News"

	private let tableView = UITableView()

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
		setupTableView()
    }

	// MARK: - Private Methods

	private func setupNavigationItem() {
		title = screenName
	}

	private func setupTabBarItem() {
		tabBarItem = UITabBarItem(title: screenName, image: #imageLiteral(resourceName: "news_gray"), selectedImage: #imageLiteral(resourceName: "news_black"))
	}

	private func setupTableView() {
		view.addSubview(tableView)
		tableView.separatorStyle = .none
		tableView.register(NewsTableViewCell.self, forCellReuseIdentifier: NewsTableViewCell.identifier)
		tableView.dataSource = self
		tableView.delegate = self
		tableView.autoPinEdge(toSuperviewMargin: .top)
		tableView.autoPinEdge(toSuperviewEdge: .leading)
		tableView.autoPinEdge(toSuperviewEdge: .trailing)
		tableView.autoPinEdge(toSuperviewMargin: .bottom)
	}
}

// MARK: - NewsListPresenterDelegate

extension NewsListViewController: NewsListPresenterDelegate {
	func updateNewsList() {
		tableView.reloadData()
	}
}

extension NewsListViewController: NewsTableViewCellDelegate {
	func cellNeedsUpdateHeight(_ cell: NewsTableViewCell) {
		if let indexPath = tableView.indexPathForRow(at: cell.center) {
			tableView.reloadData()
			tableView.scrollToRow(at: indexPath, at: .top, animated: true)
		}
	}
}

// MARK: - UITableViewDataSource

extension NewsListViewController: UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return presenter.viewModelsCount
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let viewModel = presenter.viewModelAtIndex(indexPath.row)

		let identifier = NewsTableViewCell.identifier
		let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as? NewsTableViewCell
		cell?.delegate = self
		cell?.setup(viewModel: viewModel)

		return cell ?? UITableViewCell()
	}
}

extension NewsListViewController: UITableViewDelegate {
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		presenter.selectViewAtIndex(indexPath.row)
	}
}
