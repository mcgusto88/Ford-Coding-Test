//
//  AlbumListDisplayCoordinator.swift
//  GMArtistSearch
//
//  Created by Augustus Wilson on 02/18/21.
//  Copyright © 2021 Augustus Wilson. All rights reserved.
//

import UIKit

protocol NavigationCoordinator {
    func getInitialViewController() -> UINavigationController;
}

class AlbumListNavigationCoordinator : NavigationCoordinator {
        
    func getInitialViewController() -> UINavigationController {
        let navigationController = UINavigationController()
        let urlSession = URLSession(configuration: .default)
        let albumDataLoader : AlbumsDataLoader
        let isRunningUITests = ProcessInfo.processInfo.arguments.contains("UITests")

        if isRunningUITests {
            albumDataLoader = LocalAlbumsLoader(networkClient: URLSessionNetworkClient(urlSession:urlSession) ,jsonDecoder: JSONDecoder())
        } else {
            albumDataLoader = RemoteAlbumsLoader(networkClient: URLSessionNetworkClient(urlSession:urlSession) ,jsonDecoder: JSONDecoder())
        }

        let listViewController = AlbumsListViewController(dataLoader: albumDataLoader) { _ in
            /* guard let self = self else {return}
            
              Do something with selection if required
            */
        }
        listViewController.title = "Albums"
        navigationController.viewControllers = [listViewController];
        navigationController.navigationBar.isTranslucent = false
        return navigationController;
    }
    
}



