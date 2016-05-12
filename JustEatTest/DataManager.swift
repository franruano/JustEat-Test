//
//  DataManager.swift
//  HalfTunes
//
//  Created by Fran Abucillo on 28/4/16.
//  Copyright © 2016 Ken Toh. All rights reserved.
//

import Foundation

enum DataManagerError: ErrorType {
    case InvalidResponse
    case InvalidUrl
    case InvalidStatusCode
    case InvalidJSON
}

@objc protocol DataManagerDelegate: class {
    optional func didFinishBasicNetworkRequest(data: NSDictionary?)
    optional func didFinishBasicNetworkRequestWithError(error: NSError?)
}

class DataManager: NSObject {
    
    weak var delegate: DataManagerDelegate?

    private let basicAPI = "https://public.je-apis.com/"
    private let restaurantSearch = "restaurants?q="
    
    
    
    private let defaultSession = NSURLSession(configuration: NSURLSessionConfiguration.defaultSessionConfiguration())
    private var dataTask: NSURLSessionDataTask?
    
    
    func basicRequest(parameter: String) {
        if dataTask != nil {
            dataTask?.cancel()
        }
        
        let expectedCharSet = NSCharacterSet.URLQueryAllowedCharacterSet()
        let searchTerm = parameter.stringByAddingPercentEncodingWithAllowedCharacters(expectedCharSet)!
        
        let url = NSURL(string:"\(basicAPI)\(restaurantSearch)\(searchTerm)")
        if let url = url {
            let sessionConfiguration = NSURLSessionConfiguration.defaultSessionConfiguration()
            sessionConfiguration.HTTPAdditionalHeaders = ["Accept-Tenant":"uk",
                                                            "Accept-Language":"en-GB",
                                                            "Authorization":"Basic VGVjaFRlc3RBUEk6dXNlcjI=",
                                                            "Host":"public.je-apis.com"]
            let session = NSURLSession(configuration: sessionConfiguration)
            
            dataTask = session.dataTaskWithURL(url) {
                data, response, error in
                if let error = error {
                    print(error.localizedDescription)
                    dispatch_async(dispatch_get_main_queue()) {
                        self.delegate?.didFinishBasicNetworkRequestWithError?(error)
                    }
                }
                else if let httpResponse = response as? NSHTTPURLResponse {
                    if httpResponse.statusCode == 200 {
                            do {
                                let jsonData = try NSJSONSerialization.JSONObjectWithData(data!, options: .MutableContainers) as? NSDictionary
                                dispatch_async(dispatch_get_main_queue()) {
                                    self.delegate?.didFinishBasicNetworkRequest?(jsonData)
                                }
                            } catch {
                                dispatch_async(dispatch_get_main_queue()) {
                                    self.delegate?.didFinishBasicNetworkRequestWithError?(self.createError(.InvalidJSON))
                                }
                            }
                    } else {
                        dispatch_async(dispatch_get_main_queue()) {
                            self.delegate?.didFinishBasicNetworkRequestWithError?(self.createError(.InvalidStatusCode))
                    }
                }
                } else {
                    dispatch_async(dispatch_get_main_queue()) {
                        self.delegate?.didFinishBasicNetworkRequestWithError?(nil)
                    }
                }
            }
            dataTask?.resume()
        } else {
            // Fire error
            dispatch_async(dispatch_get_main_queue()) {
                self.delegate?.didFinishBasicNetworkRequestWithError?(nil)
            }
        }
    }
}

//MARKS :- Error handler
extension DataManager {
    
    private func createError(errorResponse: DataManagerError) -> NSError {
        switch (errorResponse) {
        case .InvalidResponse:
            return NSError(domain: "NetworkDomain", code: -10, userInfo: [
                NSLocalizedDescriptionKey: "Invalid response"
                ])
        case .InvalidUrl:
            return NSError(domain: "NetworkDomain", code: -11, userInfo: [
                NSLocalizedDescriptionKey: "Invalid url"
                ])
        case .InvalidStatusCode:
            return NSError(domain: "NetworkDomain", code: -12, userInfo: [
                NSLocalizedDescriptionKey: "Invalid status code"
                ])
        case .InvalidJSON:
            return NSError(domain: "NetworkDomain", code: -13, userInfo: [
                NSLocalizedDescriptionKey: "Invalid JSON"
                ])
        }
        
    }

}