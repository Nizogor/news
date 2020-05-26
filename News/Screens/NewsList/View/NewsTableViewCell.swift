//
//  NewsTableViewCell.swift
//  News
//
//  Created by Nikita Teplyakov on 24.05.2020.
//  Copyright © 2020 Nikita Teplyakov. All rights reserved.
//

import UIKit
import SwiftyMarkdown

protocol NewsTableViewCellDelegate: class {
	func cellNeedsUpdateHeight(_ cell: NewsTableViewCell)
}

class NewsTableViewCell: UITableViewCell {

	// MARK: - Properties

	static let identifier = "NewsTableViewCell"

	weak var delegate: NewsTableViewCellDelegate?

	// MARK: - Private Properties

	private var viewModel: NewsViewModelProtocol?

	private let stackView = UIStackView()
	private let pictureView = UIImageView()
	private let dateLabel = UILabel()
	private let readStatusLabelContainer = UIView()
	private let activityIndicator = UIActivityIndicatorView(style: .large)
	private let titleLabel = UILabel()
	private let descriptionLabel = UILabel()
	private let sourceLabel = UILabel()
	private let detailsButton = UIButton()

	// MARK: - Construction

	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)

		selectionStyle = .none

		let inset: CGFloat = 5
		let edgeInsets = UIEdgeInsets(top: inset, left: inset, bottom: inset, right: inset)

		let bottomStackView = UIStackView(arrangedSubviews: [sourceLabel, detailsButton])

		detailsButton.addTarget(self, action: #selector(detailsButtonTouchUpInside(_:)), for: .touchUpInside)

		sourceLabel.setContentCompressionResistancePriority(.required, for: .horizontal)

		contentView.addSubview(stackView)
		stackView.axis = .vertical
		stackView.autoPinEdgesToSuperviewEdges(with: edgeInsets)
		stackView.addArrangedSubview(pictureView)
		stackView.addArrangedSubview(titleLabel)
		stackView.addArrangedSubview(descriptionLabel)
		stackView.addArrangedSubview(bottomStackView)

		let dateLabelContainer = UIView()
		dateLabelContainer.addSubview(dateLabel)

		pictureView.contentMode = .scaleAspectFill
		pictureView.clipsToBounds = true
		pictureView.layer.cornerRadius = 5
		pictureView.backgroundColor = .lightGray
		pictureView.autoSetDimension(.height, toSize: 200)
		pictureView.addSubview(activityIndicator)
		pictureView.addSubview(dateLabelContainer)
		pictureView.addSubview(readStatusLabelContainer)

		activityIndicator.color = .white
		activityIndicator.autoCenterInSuperview()

		dateLabelContainer.backgroundColor = UIColor(white: 1, alpha: 0.8)
		dateLabelContainer.layer.cornerRadius = 5
		dateLabelContainer.clipsToBounds = true
		dateLabelContainer.addSubview(dateLabel)
		dateLabelContainer.autoPinEdge(toSuperviewEdge: .top, withInset: inset)
		dateLabelContainer.autoPinEdge(toSuperviewEdge: .leading, withInset: inset)

		dateLabel.autoPinEdgesToSuperviewEdges(with: edgeInsets)

		readStatusLabelContainer.autoPinEdge(toSuperviewEdge: .trailing, withInset: inset)
		readStatusLabelContainer.autoPinEdge(toSuperviewEdge: .bottom, withInset: inset)

		let readStatusLabel = UILabel()
		readStatusLabel.text = "Прочитано"

		readStatusLabelContainer.backgroundColor = UIColor(white: 1, alpha: 0.8)
		readStatusLabelContainer.layer.cornerRadius = 5
		readStatusLabelContainer.addSubview(readStatusLabel)

		readStatusLabel.autoPinEdgesToSuperviewEdges(with: edgeInsets)

		titleLabel.font = .boldSystemFont(ofSize: 17)
		titleLabel.numberOfLines = 0

		descriptionLabel.textColor = .gray
		descriptionLabel.numberOfLines = 0
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	// MARK: - Methods

	func setup(viewModel: NewsViewModelProtocol) {
		self.viewModel = viewModel
		viewModel.delegate = self

		updatePictureView()
		update(isLoading: viewModel.isLoading)
		update(isCollapsed: viewModel.isCollapsed)
		update(isRead: viewModel.isRead)

		dateLabel.text = viewModel.date
		sourceLabel.text = viewModel.source
		titleLabel.text = viewModel.title
		descriptionLabel.attributedText = SwiftyMarkdown(string: viewModel.description).attributedString()
	}

	// MARK: - Private Methods

	private func updatePictureView() {
		if let data = viewModel?.imageData {
			pictureView.image = UIImage(data: data)
		} else {
			pictureView.image = nil
		}
	}

	private func update(isLoading: Bool) {
		if isLoading {
			activityIndicator.startAnimating()
		} else {
			activityIndicator.stopAnimating()
		}
	}

	private func update(isCollapsed: Bool) {
		descriptionLabel.isHidden = isCollapsed

		let normalAttributes: [NSAttributedString.Key: Any] = [.foregroundColor: UIColor.gray,
															   .font: UIFont.systemFont(ofSize: 12)]
		let selectedAttributes: [NSAttributedString.Key: Any] = [.foregroundColor: UIColor.lightGray,
																 .font: UIFont.systemFont(ofSize: 12)]
		let title = isCollapsed ? "Развернуть" : "Свернуть"
		let normalTitle = NSAttributedString(string: title, attributes: normalAttributes)
		let selectedTitle = NSAttributedString(string: title, attributes: selectedAttributes)

		detailsButton.setAttributedTitle(normalTitle, for: .normal)
		detailsButton.setAttributedTitle(selectedTitle, for: .highlighted)
	}

	private func update(shouldShowSource: Bool) {

	}

	private func update(isRead: Bool) {
		readStatusLabelContainer.isHidden = !isRead
	}

	// MARK: - Actions

	@objc private func detailsButtonTouchUpInside(_ sender: UIButton) {
		viewModel?.detailsButtonTap()
	}
}

// MARK: - NewsViewModelDelegate

extension NewsTableViewCell: NewsViewModelDelegate {
	func viewModelDidUpdate(shouldShowSource: Bool) {
		update(shouldShowSource: shouldShowSource)
	}

	func viewModelDidUpdate(isRead: Bool) {
		update(isRead: isRead)
	}

	func viewModelDidUpdate(isCollapsed: Bool) {
		update(isCollapsed: isCollapsed)
		delegate?.cellNeedsUpdateHeight(self)
	}

	func viewModelDidUpdate(isLoading: Bool) {
		update(isLoading: isLoading)
	}

	func viewModelDidUpdateImage() {
		updatePictureView()
	}
}
