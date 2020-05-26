//
//  WebPresenterProtocol.swift
//  News
//
//  Created by Nikita Teplyakov on 26/05/2020.
//  Copyright © 2020 Nikita Teplyakov. All rights reserved.
//

import Foundation

protocol WebPresenterProtocol {

	var title: String { get }
	var urlRequest: URLRequest { get }

	func requestPermissionForNavigationAction(with urlRequest: URLRequest) -> Bool
}
