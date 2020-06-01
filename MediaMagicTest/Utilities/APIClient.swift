//
//  APIClient.swift
//  MediaMagicTest
//
//  Created by Ajay Ranekar on 31/05/20.
//  Copyright © 2020 Ajay Ranekar. All rights reserved.
//

import Foundation
import UIKit

class APIClient {
    
    class func getData(apiName: String, completion: @escaping ((Any?) -> Void)) -> Void {
        
        guard let url = URL.init(string: Constants.BASE_URL + apiName) else {
            completion(Constants.INVALID_URL)
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, urlResponse, err) in
            if err != nil {
                completion(Constants.SOMETHING_WRONG)
            } else {
                completion(data)
            }
        }.resume()
        
    }
    
    class func postData(apiName: String, parameters: [String: Any],  completion: @escaping ((Any?) -> Void)) -> Void {
        
        guard let url = URL.init(string: Constants.BASE_URL + apiName) else {
            completion(Constants.INVALID_URL)
            return
        }
        
        var urlRequest = URLRequest.init(url: url, cachePolicy: .returnCacheDataDontLoad, timeoutInterval: .leastNormalMagnitude)
        
        urlRequest.httpMethod = "POST"
        
        urlRequest.httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
    
        URLSession.shared.dataTask(with: urlRequest) { (data, urlResponse, err) in
            if err != nil {
                completion(Constants.SOMETHING_WRONG)
            } else {
                completion(data)
            }
        }.resume()
        
    }
    
    
}

