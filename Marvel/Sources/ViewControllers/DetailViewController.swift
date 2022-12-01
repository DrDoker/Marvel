//
//  DetailViewController.swift
//  Marvel
//
//  Created by Serhii  on 30/11/2022.
//

import UIKit
import AlamofireImage
import SnapKit

class DetailViewController: UIViewController {
	
	// MARK: - Properties
	
	private var comics: [ComicsItem] = []
	
	private lazy var characterName: UILabel = {
		let label = UILabel()
		label.textColor = .black
		label.font = UIFont.systemFont(ofSize: 22, weight: .bold)
		return label
	}()
	
	private lazy var characterImage: UIImageView = {
		let imageView = UIImageView()
		imageView.contentMode = .scaleAspectFill
		imageView.clipsToBounds = true
		imageView.layer.cornerRadius = 10
		return imageView
	}()
	
	private lazy var tableView: UITableView = {
		let table = UITableView(frame: .zero, style: .grouped)
		table.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
		table.delegate = self
		table.dataSource = self
		return table
	}()

	// MARK: - Lifecycle
		
	override func viewDidLoad() {
		super.viewDidLoad()
		view.backgroundColor = .white
		
		setupHierarchy()
		setupLayout()
	}
	
	// MARK: - Setup
	
	private func setupHierarchy() {
		view.addSubview(characterName)
		view.addSubview(characterImage)
		view.addSubview(tableView)
	}
	
	private func setupLayout() {
		
		characterName.snp.makeConstraints { make in
			make.top.equalTo(view).offset(50)
			make.centerX.equalTo(view)
		}
		
		characterImage.snp.makeConstraints { make in
			make.top.equalTo(characterName.snp.bottom).offset(30)
			make.centerX.equalTo(view)
			make.width.height.equalTo(200)
		}
		
		tableView.snp.makeConstraints { make in
			make.top.equalTo(characterImage.snp.bottom).offset(40)
			make.left.right.bottom.equalTo(view)
		}
	}
}

extension DetailViewController: UITableViewDataSource, UITableViewDelegate {
	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		50
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return self.comics.count
	}
	
	func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
	   return "Comics"
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
		cell.textLabel?.text = comics[indexPath.row].name
		return cell
	}
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		tableView.deselectRow(at: indexPath, animated: true)
	}
}

extension DetailViewController {
	func configureWith(model: Character) {
		self.characterName.text = model.name
		self.comics = model.comics.items
		characterImage.image = UIImage(named: "DefaultCharacterImage")
		
		let url = model.thumbnail.thumbnailURL
		guard let imageURL = URL(string: url) else { return }
		characterImage.af.setImage(withURL: imageURL)
	}
}

