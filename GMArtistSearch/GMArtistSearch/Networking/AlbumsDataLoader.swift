//
//  AlbumService.swift
//  Koala
//
//  Created by Augustus Wilson on 9/17/20.
//  Copyright © 2021 Augustus Wilson. All rights reserved.
//

import Foundation

protocol AlbumsDataLoader {
    var networkClient : HTTPClient { get }
    var jsonDecoder : JSONDecoder { get }
    func getAlbums(searchTerm:String , completion: ((Result<[Album],CustomError>)->Void)?);
}

class RemoteAlbumsLoader : AlbumsDataLoader {
    var networkClient: HTTPClient
    var jsonDecoder: JSONDecoder
    init(networkClient:HTTPClient,jsonDecoder:JSONDecoder) {
        self.networkClient = networkClient
        self.jsonDecoder = jsonDecoder
    }
    
    private let albumsBaseUrl = "https://itunes.apple.com/search?term=";
    
    func getAlbums(searchTerm: String, completion: ((Result<[Album], CustomError>) -> Void)?) {
        let albumsUrl = (albumsBaseUrl + searchTerm).addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        networkClient.get(url: albumsUrl) {  [weak self] result in
            guard let self = self else {return}
            switch(result){
            case .success(let data):
                do {
                    let albums = try self.jsonDecoder.decode(AlbumFeed.self, from: data).results
                    completion?(.success(albums))
                }
                catch (let error) {
                    print(error)
                    completion?(.failure(.decodeError))
                }
                break;
            case.failure(let error):
                completion?(.failure(error))
            }
        }
    }
    
    func getAlbumImage(url:String)  {
        
    }
}

class LocalAlbumsLoader : AlbumsDataLoader {
    var networkClient: HTTPClient
    
    var jsonDecoder: JSONDecoder
    
    init(networkClient:HTTPClient,jsonDecoder:JSONDecoder) {
        self.networkClient = networkClient
        self.jsonDecoder = jsonDecoder
    }
    
    func getAlbums(searchTerm: String, completion: ((Result<[Album], CustomError>) -> Void)?) {
        if let path = Bundle.main.path(forResource: "MockAlbums", ofType: "json") {
            let url = URL(fileURLWithPath: path)
            do {
                let data = try Data(contentsOf: url)
                let albums = try self.jsonDecoder.decode(AlbumFeed.self, from: data).results
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    completion?(.success(albums))
                }
            }
            catch {
                completion?(.failure(.decodeError))
            }
        }
    }
    
}



