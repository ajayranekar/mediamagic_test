//
//  AuthorDataModel.swift
//  MediaMagicTest
//
//  Created by Ajay Ranekar on 31/05/20.
//  Copyright © 2020 Ajay Ranekar. All rights reserved.
//

import Foundation
import UIKit

/// image cache object
private let cache = NSCache<NSString, UIImage>()

// MARK:- Model Class
class AuthorDataModel: Codable {
    
    let format: String
    let width, height: Int
    let filename: String
    let id: Int
    let author: String
    let authorURL, postURL: String

    enum CodingKeys: String, CodingKey {
        case format, width, height, filename, id, author
        case authorURL = "author_url"
        case postURL = "post_url"
    }
    
    func getAuthorURL() -> String {
        return Constants.IMAGE_FOR_ID + "\(self.id)"
    }
    
    var authImage: UIImage?
    
    // MARK:- Image caching mechanism
    
    var task = URLSessionDataTask()
    var session = URLSession.shared
    
    // method for fetching image from url
    func fetchImage(completionHandler: ((UIImage?) -> Void)? ) -> Void {
        
        guard let url = URL.init(string: Constants.IMAGE_FOR_ID + "\(self.id)") else {
            authImage = nil
            completionHandler?(nil)
            return
        }
        
        if let imageInCache = cache.object(forKey: url.absoluteString as NSString)  {
            authImage = imageInCache
            completionHandler?(imageInCache)
            return
        }
        
        self.task = self.session.dataTask(with: url) { data, response, error in
            DispatchQueue.main.async {
                if let _ = error {
                    self.authImage = nil
                    completionHandler?(nil)
                    return
                }
                
                if let imageDownloaded = UIImage(data: data!) {
                    completionHandler?(imageDownloaded)
                    self.authImage = imageDownloaded
                    cache.setObject(imageDownloaded, forKey: url.absoluteString as NSString)
                }
            }
        }
        
        self.task.resume()
    }
    
    
    func cancelFetchImage() {
        self.task.suspend()
    }
    
}
