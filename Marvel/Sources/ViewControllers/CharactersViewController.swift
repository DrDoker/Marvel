//
//  ViewController.swift
//  Marvel
//
//  Created by Serhii  on 02/11/2022.
//

import UIKit
import Alamofire

class CharactersViewController: UIViewController {
	
	let testURL = "https://gateway.marvel.com/v1/public/characters?nameStartsWith=Spider&orderBy=-modified&ts=Serhii-Tkachenko&apikey=d8182c561967ebc637775965e3484849&hash=c4fb21a13465834c8d7d8d816f45c16a"

	override func viewDidLoad() {
		super.viewDidLoad()
		view.backgroundColor = .white
		fetchCharacter()
	}
}

extension CharactersViewController {
	
	func fetchCharacter() {
		let request = AF.request(testURL)
		request.responseDecodable(of: CharactersApiResponse.self) { (data) in
			guard let data = data.value else { return }
			data.charactersData.characters.forEach { (character) in
				print()
				print(character.name)
				print(character.thumbnail.thumbnailURL)
				print(character.description)
			}
		}
	}
}




