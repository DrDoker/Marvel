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
	
	private lazy var searchTextField: UITextField = {
		let textField = UITextField()
		textField.placeholder = "Введи имя"
		textField.textAlignment = .center
		textField.backgroundColor = .white
		textField.layer.cornerRadius = 20
		return textField
	}()
	
	private lazy var searchButton: UIButton = {
		let button = UIButton(type: .system)
		button.setTitle("Search", for: .normal)
		button.tintColor = .white
		button.backgroundColor = .systemBlue
		button.layer.cornerRadius = 20
		button.addTarget(self, action: #selector(search), for: .touchUpInside)
		return button
	}()
	
	
	// MARK: - Lifecycle
	
	override func viewDidLoad() {
		super.viewDidLoad()
		view.backgroundColor = .systemYellow
		
		setupHierarchy()
		setupLayout()
		
	}
	
	// MARK: - Setup
	
	private func setupHierarchy() {
		view.addSubview(searchTextField)
		view.addSubview(searchButton)
	}
	
	private func setupLayout() {
		searchTextField.snp.makeConstraints { make in
			make.bottom.equalTo(searchButton.snp.top).offset(-50)
			make.left.equalTo(view).offset(30)
			make.right.equalTo(view).offset(-30)
			make.height.equalTo(50)
		}
		
		searchButton.snp.makeConstraints { make in
			make.center.equalTo(view)
			make.height.equalTo(50)
			make.width.equalTo(150)
		}
	}
	
	// MARK: - Actions
	
	@objc func search() {
		navigationController?.pushViewController(CharactersViewController(), animated: true)
	}
	
}
