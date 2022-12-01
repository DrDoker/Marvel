//
//  CharactersTableViewCell.swift
//  Marvel
//
//  Created by Serhii  on 03/11/2022.
//

import UIKit
import AlamofireImage

class CharactersTableViewCell: UITableViewCell {
	
	static let identifier = "CharactersCell"
	
	var character: Character? {
		didSet {
			title.text = character?.name
			secondTitle.text = character?.description
			characterImage.image = UIImage(named: "DefaultCharacterImage")
			
			guard let url = character?.thumbnail.thumbnailURL,
				  let imageURL = URL(string: url)
			else { return }
			
			characterImage.af.setImage(withURL: imageURL)
		}
	}

	//MARK: - Outlets
	
	lazy var characterImage: UIImageView = {
		let imageView = UIImageView()
		imageView.contentMode = .scaleAspectFill
		imageView.clipsToBounds = true
		imageView.layer.cornerRadius = 10
		return imageView
	}()
	
	lazy var title: UILabel = {
		let lable = UILabel()
		lable.textColor = .black
		lable.font = UIFont.systemFont(ofSize: 17, weight: .regular)
		return lable
	}()
	
	lazy var secondTitle: UILabel = {
		let lable = UILabel()
		lable.textColor = .black
		lable.font = UIFont.systemFont(ofSize: 14, weight: .regular)
		return lable
	}()
	
	private lazy var infoStack: UIStackView = {
		let stack = UIStackView()
		stack.alignment = .fill
		stack.axis = .vertical
		stack.distribution = .fill
		stack.spacing = 4
		return stack
	}()
	
	//MARK: - Initializers
	
	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		setupHierarchy()
		setupLayout()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	// MARK: - Setup
	
	private func setupHierarchy() {
		contentView.addSubview(characterImage)
		contentView.addSubview(infoStack)
		
		infoStack.addArrangedSubview(title)
		infoStack.addArrangedSubview(secondTitle)
	}
	
	private func setupLayout() {
		characterImage.snp.makeConstraints { make in
			make.centerY.equalTo(contentView)
			make.left.equalTo(contentView).offset(15)
			make.height.equalTo(120)
			make.width.equalTo(90)
		}
		
		infoStack.snp.makeConstraints { make in
			make.centerY.equalTo(contentView)
			make.left.equalTo(characterImage.snp.right).offset(20)
			make.right.equalTo(contentView).offset(-20)
		}
	}
	
}
