//
//  Characters.swift
//  Marvel
//
//  Created by Serhii  on 02/11/2022.
//

import Foundation

struct CharactersApiResponse: Decodable {
	let code: Int
	let charactersData: Characters
	
	enum CodingKeys: String, CodingKey {
		case code
		case charactersData = "data"
	}
}

struct Characters: Decodable {
	let total: Int
	let count: Int
	let characters: [Character]
	
	enum CodingKeys: String, CodingKey {
		case total
		case count
		case characters = "results"
	}
}

struct Character: Decodable {
	let id: Int
	let name: String
	let description: String
	let thumbnail: Thumbnail
	let comics: Comics
	
}

struct Thumbnail: Codable {
	let path: String
	let thumbnailExtension: String

	enum CodingKeys: String, CodingKey {
		case path
		case thumbnailExtension = "extension"
	}
	
	var thumbnailURL: String {
		path + "." + thumbnailExtension
	}
}

struct Comics: Codable {
	let items: [ComicsItem]
}

struct ComicsItem: Codable {
	let name: String
}
