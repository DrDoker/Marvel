//
//  MainViewController.swift
//  Marvel
//
//  Created by Serhii  on 03/11/2022.
//

import UIKit
import SnapKit

class MainViewController: UIViewController {
	
	// MARK: - Outlets
	
	private lazy var backgroundImageView: UIImageView = {
		let imageView = UIImageView(frame: .zero)
		imageView.image = UIImage(named: "MarvelBackground")
		imageView.contentMode = .scaleToFill
		return imageView
	}()
	
	private lazy var logoImageView: UIImageView = {
		let imageView = UIImageView(frame: .zero)
		imageView.image = UIImage(named: "MarvelLogo")
		imageView.contentMode = .scaleToFill
		return imageView
	}()
	
	private lazy var searchTextField: UITextField = {
		let textField = UITextField()
		textField.attributedPlaceholder = NSAttributedString(
			string: "Enter a character name",
			attributes: [NSAttributedString.Key.foregroundColor: UIColor(named: "placeholderColor") ?? .systemGray6])
		textField.textAlignment = .center
		textField.backgroundColor = UIColor(named: "searchTextFieldColor")
		textField.layer.cornerRadius = 18
		return textField
	}()
	
	private lazy var searchButton: UIButton = {
		let button = UIButton(type: .system)
		button.setTitle("Search", for: .normal)
		button.tintColor = .white
		button.backgroundColor = UIColor(named: "searchButtonColor")
		button.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
		button.layer.cornerRadius = 18
		button.addTarget(self, action: #selector(search), for: .touchUpInside)
		return button
	}()
	
	
	// MARK: - Lifecycle
	
	override func viewDidLoad() {
		super.viewDidLoad()
		view.backgroundColor = .black
		
		setupHierarchy()
		setupLayout()
		
	}
	
	// MARK: - Setup
	
	private func setupHierarchy() {
		view.addSubview(backgroundImageView)
		view.addSubview(logoImageView)
		view.addSubview(searchTextField)
		view.addSubview(searchButton)
	}
	
	private func setupLayout() {
		backgroundImageView.snp.makeConstraints { make in
			make.top.left.bottom.right.equalTo(view)
		}
		
		logoImageView.snp.makeConstraints { make in
			make.height.equalTo(90)
			make.width.equalTo(230)
			make.centerX.equalTo(view)
			make.top.equalTo(view).offset(130)
		}
		
		searchTextField.snp.makeConstraints { make in
			make.bottom.equalTo(searchButton.snp.top).offset(-34)
			make.left.equalTo(view).offset(38)
			make.right.equalTo(view).offset(-38)
			make.height.equalTo(52)
		}
		
		searchButton.snp.makeConstraints { make in
			make.centerX.equalTo(view)
			make.centerY.equalTo(view).offset(60)
			make.left.equalTo(view).offset(38)
			make.right.equalTo(view).offset(-38)
			make.height.equalTo(60)
		}
	}
	
	// MARK: - Actions
	
	@objc func search() {
		guard let searchText = searchTextField.text else { return }
		
		if searchText == "" {
			self.showAlert(withTitle: "Warning", andMessage: "Enter a character name")
		} else {
			let charactersViewController = CharactersViewController(name: searchText)
			navigationController?.pushViewController(charactersViewController, animated: true)
		}
	}
}


