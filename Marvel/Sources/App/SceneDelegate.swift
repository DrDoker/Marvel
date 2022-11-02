//
//  SceneDelegate.swift
//  Marvel
//
//  Created by Serhii  on 02/11/2022.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

	var window: UIWindow?

	func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
		guard let windowScene = (scene as? UIWindowScene) else { return }
		window = UIWindow(windowScene: windowScene)
		window?.rootViewController = ViewController()
		window?.makeKeyAndVisible()
	}

}

