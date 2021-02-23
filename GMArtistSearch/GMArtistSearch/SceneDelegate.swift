//
//  SceneDelegate.swift
//  GMArtistSearch
//
//  Created by Augustus Wilson on 2/18/21.
//  Copyright © 2021 Augustus Wilson. All rights reserved.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    
    private var navigationCoordinator : NavigationCoordinator?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let _ = (scene as? UIWindowScene) else { return }
        
        if let windowScene = scene as? UIWindowScene {
            let window = UIWindow(windowScene: windowScene)
            self.window = window
            navigationCoordinator = AlbumListNavigationCoordinator()
            window.rootViewController = navigationCoordinator?.getInitialViewController();
            window.makeKeyAndVisible()
        }
    }

}

