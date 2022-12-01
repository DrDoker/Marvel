//
//  ViewController.swift
//  Marvel
//
//  Created by Serhii  on 02/11/2022.
//

import UIKit
import Alamofire

class CharactersViewController: UIViewController {
	
	// MARK: - Properties
	
	var characters: [Character] = []
	var name: String = ""
	
	lazy var tableView: UITableView = {
		let table = UITableView(frame: .zero, style: .grouped)
		table.register(CharactersTableViewCell.self, forCellReuseIdentifier: CharactersTableViewCell.identifier)
		table.delegate = self
		table.dataSource = self
		return table
	}()
	
	// MARK: - Lifecycle
	
	convenience init(name: String) {
		self.init()
		self.name = name
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		setupHierarchy()
		setupLayout()
		fetchCharacter(nameStartsWith: name)
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
		let detailViewController = DetailViewController()
		detailViewController.configureWith(model: characters[indexPath.row])
		present(detailViewController, animated: true)
	}
}

extension CharactersViewController {
	
	func fetchCharacter(nameStartsWith: String) {
		NetworkService.shared.fetchData(searchItem: nameStartsWith) { [weak self] result in
			switch result {
			case .success(let data):
				self?.characters = data.charactersData.characters
				self?.tableView.reloadData()
			case .failure(let error):
				print(error.localizedDescription)
			}
		}
	}
}
