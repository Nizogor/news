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

	private let tableView = UITableView(frame: .zero, style: .grouped)

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
		setupTableView()
    }

	// MARK: - Private Methods

	private func setupNavigationItem() {
		navigationItem.title = screenName
	}

	private func setupTableView() {
		view.addSubview(tableView)
		tableView.autoPinEdge(toSuperviewMargin: .top)
		tableView.autoPinEdge(toSuperviewEdge: .leading)
		tableView.autoPinEdge(toSuperviewEdge: .trailing)
		tableView.autoPinEdge(toSuperviewMargin: .bottom)
		tableView.dataSource = self
		tableView.delegate = self
		tableView.register(UpdateTimeSettingsCell.self, forCellReuseIdentifier: UpdateTimeSettingsCell.identifier)
		tableView.register(SourcesListCell.self, forCellReuseIdentifier: SourcesListCell.identifier)
	}

	private func cellForUpdateTimeSection(indexPath: IndexPath, viewModel: UpdateTimeSettingsViewModelProtocol) -> UITableViewCell? {
		let identifier = UpdateTimeSettingsCell.identifier
		let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as? UpdateTimeSettingsCell
		cell?.setup(viewModel: viewModel)

		return cell
	}

	private func cellForSourcesListSection(indexPath: IndexPath, sources: [SourcesListSettingsModel]) -> UITableViewCell? {
		let identifier = SourcesListCell.identifier
		let model = sources[indexPath.row]
		let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as? SourcesListCell
		cell?.setup(model: model)

		return cell
	}
}

// MARK: - SettingsPresenterDelegate

extension SettingsViewController: SettingsPresenterDelegate {
	func reloadSettingsList() {
		tableView.reloadData()
	}
}

// MARK: - UITableViewDataSource

extension SettingsViewController: UITableViewDataSource {
	func numberOfSections(in tableView: UITableView) -> Int {
		return presenter.sections.count
	}

	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		switch presenter.sections[section] {
		case .updateTime:
			return 1
		case .newsSources(_, let sources):
			return sources.count
		}
	}

	func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
		switch presenter.sections[section] {
		case .updateTime(let title, _),
			 .newsSources(let title, _):
			return title
		}
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		var cell: UITableViewCell?

		switch presenter.sections[indexPath.section] {
		case .updateTime(_, let viewModel):
			cell = cellForUpdateTimeSection(indexPath: indexPath, viewModel: viewModel)
		case .newsSources(_, let sources):
			cell = cellForSourcesListSection(indexPath: indexPath, sources: sources)
		}

		return cell ?? UITableViewCell()
	}
}

// MARK: - UITableViewDelegate

extension SettingsViewController: UITableViewDelegate {
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		tableView.deselectRow(at: indexPath, animated: false)

		let section = presenter.sections[indexPath.section]

		switch section {
		case .newsSources:
			presenter.selectSourceAtIndex(indexPath.row)
		default:
			break
		}
	}
}
