//
//  ReminderProtocol.swift
//  NewsKit
//
//  Created by Nikita Teplyakov on 27.05.2020.
//  Copyright © 2020 Nikita Teplyakov. All rights reserved.
//

public protocol ReminderDelegate: class {
	func reminderDidNotificate()
}

public protocol ReminderProtocol: class {

	var delegate: ReminderDelegate? { get set }

	func remind(timeInterval: TimeInterval)
}
