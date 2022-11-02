//
//  Characters.swift
//  Marvel
//
//  Created by Serhii  on 02/11/2022.
//

import Foundation

struct ApiResponse: Codable {
	let code: Int
	let characters: Characters
	
	enum CodingKeys: String, CodingKey {
		case code
		case characters = "data"
	}
}

struct Characters: Codable {
	let total: Int
	let count: Int
	let character: [Character]
	
	enum CodingKeys: String, CodingKey {
		case total
		case count
		case characters = "results"
	}
}

struct Character: Codable {
	let id: Int
	let name: String
	let description: String
//	let thumbnail: Thumbnail
//	let comics: Comics
}
