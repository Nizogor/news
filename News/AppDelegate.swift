//
//  AppDelegate.swift
//  News
//
//  Created by Nikita Teplyakov on 15.05.2020.
//  Copyright © 2020 Nikita Teplyakov. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

	var window: UIWindow?

	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

		window = UIWindow(frame: UIScreen.main.bounds)
		window?.rootViewController = UIViewController()
		window?.makeKeyAndVisible()

		return true
	}
}

