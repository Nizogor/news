//
//  NewsObject.swift
//  NewsKit
//
//  Created by Nikita Teplyakov on 16.05.2020.
//  Copyright © 2020 Nikita Teplyakov. All rights reserved.
//

import RealmSwift

class NewsObject: Object {
	@objc dynamic var source: String = ""
	@objc dynamic var link: String = ""
	@objc dynamic var date: String = ""
	@objc dynamic var title: String = ""
	@objc dynamic var imageLink: String? = nil
	@objc dynamic var shortDescription: String = ""

	override static func primaryKey() -> String? {
        return "link"
    }
}
