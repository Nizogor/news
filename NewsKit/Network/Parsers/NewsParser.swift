//
//  NewsParser.swift
//  NewsKit
//
//  Created by Nikita Teplyakov on 16.05.2020.
//  Copyright © 2020 Nikita Teplyakov. All rights reserved.
//

private enum ElementType: String {
	case title
	case link
	case pubDate
	case description
	case enclosure
}

class NewsParser: XMLParser {

	// MARK: - Private Properties

	private let encoder = JSONEncoder()
	private let decoder = JSONDecoder()

	private var currentItem: [String: String]?
	private var currentElement: ElementType?
	private var items: [NewsAPIModel] = []
	private var completionHandler: ((Result<[NewsAPIModel], Error>) -> ())?

	private let itemElementName = "item"

	// MARK: - Construction

	override init(data: Data) {
		super.init(data: data)

		delegate = self
	}

	// MARK: - Private Methods

	private func makeNewsModel(attributes: [String: String]) throws -> NewsAPIModel {
		let data = try encoder.encode(attributes)
		return try decoder.decode(NewsAPIModel.self, from: data)
	}
}

extension NewsParser: NewsParserProtocol {
	func fetchNews(completion: @escaping (Result<[NewsAPIModel], Error>) -> ()) {
		completionHandler = completion

		if !parse(), let error = parserError {
			completion(.failure(error))
		}
	}
}

extension NewsParser: XMLParserDelegate {
	func parserDidStartDocument(_ parser: XMLParser) {
		items = []
	}

	func parserDidEndDocument(_ parser: XMLParser) {
		if let error = parser.parserError {
			completionHandler?(.failure(error))
		} else {
			completionHandler?(.success(items))
		}
	}

	func parser(_ parser: XMLParser,
				didStartElement elementName: String,
				namespaceURI: String?, qualifiedName qName: String?,
				attributes attributeDict: [String : String] = [:]) {
		guard elementName != itemElementName else {
			currentItem = [:]
			return
		}

		guard currentItem != nil else { return }

		currentElement = ElementType(rawValue: elementName)

		switch currentElement {
		case .some(let element) where element == .enclosure:
			currentItem?[element.rawValue] = attributeDict["url"]
		default:
			break
		}
	}

	func parser(_ parser: XMLParser, foundCharacters string: String) {
		guard let element = currentElement else {
			return
		}

		switch element {
		case .link, .pubDate, .title, .description:
			let currentValue = currentItem?[element.rawValue]
			currentItem?[element.rawValue] = (currentValue ?? "") + string
		case .enclosure:
			break
		}
	}

	func parser(_ parser: XMLParser,
				didEndElement elementName: String,
				namespaceURI: String?,
				qualifiedName qName: String?) {
		let isItem = elementName == itemElementName
		if isItem, let item = currentItem {
			do {
				let item = try makeNewsModel(attributes: item)
				items.append(item)
			} catch {
				parser.abortParsing()
				completionHandler?(.failure(error))
			}
		} else {
			currentElement = nil
		}
	}

	func parser(_ parser: XMLParser, parseErrorOccurred parseError: Error) {
		completionHandler?(.failure(parseError))
	}

	func parser(_ parser: XMLParser, validationErrorOccurred validationError: Error) {
		completionHandler?(.failure(validationError))
	}
}
