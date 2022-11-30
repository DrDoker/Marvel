//
//  Constants.swift
//  Marvel
//
//  Created by Serhii  on 30/11/2022.
//

import Foundation
import UIKit

enum Constants {

	enum Keys {
		static let privateKey = "2895055c5371280d7387073cc3ef477e45632869"
		static let publicKey = "d8182c561967ebc637775965e3484849"
		static let tsString = "1"
	}

	enum URL {
		static let scheme = "https"
		static let host = "gateway.marvel.com"
		static let path = "/v1/public/characters"
	}
}
