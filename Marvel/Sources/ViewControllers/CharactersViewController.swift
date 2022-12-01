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
	
	private lazy var loadingImageView: UIImageView = {
		let imageView = UIImageView()
		imageView.image = UIImage.gifImageWithName("marvelLoad")
		imageView.contentMode = .scaleAspectFit
		return imageView
	}()
	
	private lazy var tableView: UITableView = {
		let table = UITableView(frame: .zero, style: .grouped)
		table.register(CharactersTableViewCell.self, forCellReuseIdentifier: CharactersTableViewCell.identifier)
		table.delegate = self
		table.dataSource = self
		return table
	}()
	
	private lazy var notFoundImageView: UIImageView = {
		let imageView = UIImageView()
		imageView.image = UIImage(named: "notFoundGroot")
		imageView.contentMode = .scaleAspectFit
		return imageView
	}()
	
	lazy var notFoundLabel: UILabel = {
		let lable = UILabel()
		lable.textColor = .black
		lable.font = UIFont.systemFont(ofSize: 25, weight: .bold)
		lable.text = "It's all bullshit, nothing was found"
		lable.textAlignment = .center
		lable.numberOfLines = 0
		return lable
	}()
	
	private lazy var notFoundStackView: UIStackView = {
		let stackView = UIStackView()
		stackView.axis = .vertical
		stackView.distribution = .fill
		stackView.alignment = .fill
		stackView.spacing = 30
		stackView.isHidden = true
		return stackView
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
		view.addSubview(loadingImageView)
		view.addSubview(notFoundStackView)
		notFoundStackView.addArrangedSubview(notFoundImageView)
		notFoundStackView.addArrangedSubview(notFoundLabel)
	}
	
	private func setupLayout() {
		loadingImageView.snp.makeConstraints { make in
			make.center.equalTo(view)
			make.width.equalTo(220)
		}
		
		notFoundStackView.snp.makeConstraints { make in
			make.center.equalTo(view)
			make.left.equalTo(view).offset(30)
			make.right.equalTo(view).offset(-30)
			make.height.equalTo(300)

		}
		
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
				if data.charactersData.total == 0 {
					self?.notFoundStackView.isHidden = false
				} else {
					self?.characters = data.charactersData.characters
					self?.tableView.reloadData()
				}
			case .failure(let error):
				self?.showAlert(withTitle: "Error", andMessage: error.localizedDescription)
			}
			self?.loadingImageView.isHidden = true
		}
	}
}
