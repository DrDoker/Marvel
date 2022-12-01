//
//  NetworkService.swift
//  Marvel
//
//  Created by Serhii  on 30/11/2022.
//

import Foundation
import Alamofire

final class NetworkService {
	
	static let shared = NetworkService()
	
	private func getHash() -> String {
		let stringForHash = Constants.Keys.tsString + Constants.Keys.privateKey + Constants.Keys.publicKey
		return stringForHash.md5()
	}
	
	func fetchData(searchItem: String, completion: @escaping (Result<CharactersApiResponse, Error>) -> ()) {
		
		var urlComponents = URLComponents()
		urlComponents.scheme = Constants.URL.scheme
		urlComponents.host = Constants.URL.host
		urlComponents.path = Constants.URL.path
		urlComponents.queryItems = [
		   URLQueryItem(name: "nameStartsWith", value: searchItem),
		   URLQueryItem(name: "ts", value: Constants.Keys.tsString),
		   URLQueryItem(name: "apikey", value: Constants.Keys.publicKey),
		   URLQueryItem(name: "hash", value: getHash())
		]
		
		let urlString = urlComponents.string ?? ""
		getMarvelData(forURL: urlString, completion: completion)
	}
	
	func getMarvelData(forURL url: String, completion: @escaping (Result<CharactersApiResponse, Error>) -> ()) {
		AF.request(url)
			.validate()
			.responseDecodable(of: CharactersApiResponse.self) { (response) in
				guard let data = response.value else {
					if let error = response.error {
						completion(.failure(error))
					}
					return
				}
				completion(.success(data))
			}
	}
}
