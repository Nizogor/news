//
//  Reminder.swift
//  NewsKit
//
//  Created by Nikita Teplyakov on 27.05.2020.
//  Copyright © 2020 Nikita Teplyakov. All rights reserved.
//

public class Reminder {

	// MARK: - Properties

	public weak var delegate: ReminderDelegate?

	// MARK: - Private Properties

	private var timer: Timer?
	private var lastTickTime = Date()

	// MARK: - Construction

	public init() {}

	deinit { timer?.invalidate() }
}

// MARK: - ReminderProtocol

extension Reminder: ReminderProtocol {
	public func remind(timeInterval: TimeInterval) {
		guard delegate != nil else { return }

		lastTickTime = Date()

		timer?.invalidate()
		timer = Timer.scheduledTimer(withTimeInterval: timeInterval, repeats: true, block: { [weak self] timer in
			guard let lastTickTime = self?.lastTickTime,
				abs(lastTickTime.timeIntervalSinceNow) >= timeInterval else {
				return
			}

			self?.delegate?.reminderDidNotificate()
		})
	}
}
