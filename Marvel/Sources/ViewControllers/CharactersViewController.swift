//
//  ViewController.swift
//  Marvel
//
//  Created by Serhii  on 02/11/2022.
//

import UIKit
import Alamofire

class CharactersViewController: UIViewController {
	
	var characters: [Character] = []
	
	lazy var tableView: UITableView = {
		let table = UITableView(frame: .zero, style: .grouped)
		table.register(CharactersTableViewCell.self, forCellReuseIdentifier: CharactersTableViewCell.identifier)
		table.delegate = self
		table.dataSource = self
		return table
	}()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		fetchCharacter()
		setupHierarchy()
		setupLayout()
	}
	
	// MARK: - Setup
	
	private func setupHierarchy() {
		view.addSubview(tableView)
	}
	
	private func setupLayout() {
		tableView.snp.makeConstraints { make in
			make.top.left.right.bottom.equalTo(view)
		}
	}
}

extension CharactersViewController: UITableViewDataSource, UITableViewDelegate {
	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		130
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return self.characters.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: CharactersTableViewCell.identifier) as? CharactersTableViewCell
		guard let cell = cell else { return UITableViewCell() }
		cell.character = characters[indexPath.row]
		return cell
	}
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		tableView.deselectRow(at: indexPath, animated: true)
		print(characters[indexPath.row])
	}
}


extension CharactersViewController {
	
	func fetchCharacter() {
		let testURL = "https://gateway.marvel.com/v1/public/characters?nameStartsWith=Spider&orderBy=-modified&ts=Serhii-Tkachenko&apikey=d8182c561967ebc637775965e3484849&hash=c4fb21a13465834c8d7d8d816f45c16a"
		
		let request = AF.request(testURL)
		request.responseDecodable(of: CharactersApiResponse.self) { (data) in
			guard let data = data.value else { return }
			self.characters = data.charactersData.characters
			self.tableView.reloadData()
		}
	}
}




