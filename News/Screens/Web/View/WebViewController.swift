//
//  WebViewController.swift
//  News
//
//  Created by Nikita Teplyakov on 26/05/2020.
//  Copyright © 2020 Nikita Teplyakov. All rights reserved.
//

import UIKit
import WebKit

class WebViewController: UIViewController {

    // MARK: - Private Properties

    private let presenter: WebPresenterProtocol

	private let webView = WKWebView()
	private let activityIndicator = UIActivityIndicatorView()

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

		setupView()
		setupNavigationItem()
		setupActivityIndicator()
		setupWebView()
    }

	// MARK: - Private Methods

	private func setupView() {
		view.backgroundColor = .white
		view.addSubview(webView)
	}

	private func setupNavigationItem() {
		navigationItem.title = presenter.title
		navigationItem.rightBarButtonItem = UIBarButtonItem(customView: activityIndicator)
	}

	private func setupActivityIndicator() {
		activityIndicator.color = .systemBlue
	}

	private func setupWebView() {
		webView.autoPinEdge(toSuperviewMargin: .top)
		webView.autoPinEdge(toSuperviewEdge: .leading)
		webView.autoPinEdge(toSuperviewEdge: .trailing)
		webView.autoPinEdge(toSuperviewMargin: .bottom)
		webView.navigationDelegate = self
		webView.load(presenter.urlRequest)
	}
}

// MARK: - WebPresenterDelegate

extension WebViewController: WebPresenterDelegate {

}

extension WebViewController: WKNavigationDelegate {
	func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
		activityIndicator.startAnimating()
	}

	func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
		activityIndicator.stopAnimating()
	}

	func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
		activityIndicator.stopAnimating()
	}
}
