//
//  SceneDelegate.swift
//  Coffe
//
//  Created by Денис Николаев on 28.10.2024.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        
        let loginModule = LoginRouter.createModule()
        let navigationController = UINavigationController(rootViewController: loginModule) 
        
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
}
