//
//  ImageViewExtension.swift
//  GMArtistSearch
//
//  Created by Augustus Wilson on 02/18/21.
//  Copyright © 2021 Augustus Wilson. All rights reserved.
//

import UIKit
let imageCache = NSCache<NSString, UIImage>()

extension UIImageView {
    func loadImageUsingCache(withUrl urlString : String) {
        guard let url  = URL(string: urlString) else { return }

        self.image = UIImage(named: "placeholder")

        if let cachedImage = imageCache.object(forKey: urlString as NSString)  {
            self.image = cachedImage
        } else {
            URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
                if error != nil { return }
                DispatchQueue.main.async {
                    if let data = data , let image = UIImage(data: data) {
                        imageCache.setObject(image, forKey: urlString as NSString)
                        self.image = image
                    }
                }
            }).resume()
        }
    }
}

//extension UIImageView {
//    func loadImageUsingCache(withUrl urlString : String) {
//        self.image = UIImage(named: "placeholder")
//        if let cachedImage = imageCache.object(forKey: urlString as NSString)  {
//            self.image = cachedImage
//        } else {
//            let session = URLSession(configuration: .default)
//            URLSessionNetworkClient(urlSession: session).get(url: urlString, queryParameters: nil) { [weak self] result in
//                guard let self = self else {return}
//                switch result {
//                case .success(let data):
//                    DispatchQueue.main.async {
//                        if let image = UIImage(data: data) {
//                            imageCache.setObject(image, forKey: urlString as NSString)
//                            self.image = image
//                        }
//                    }
//                case .failure(_):
//                    break;
//                }
//            }
//        }
//    }
//}
