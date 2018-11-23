//
//  Router.swift
//  Glosso
//
//  Created by sequenia on 08/11/2018.
//  Copyright © 2018 Sequenia. All rights reserved.
//

import Alamofire

public enum HTTPHeaderField: String {
    case contentType = "Content-Type"
    case acceptType  = "Accept"
    case xAuthToken  = "X-Auth-Token"
}

public enum ContentType: String {
    case json = "application/json"
}

public protocol Router: URLRequestConvertible {
    
    var baseURL:     String            { get }
    var timeout:     TimeInterval      { get }
    
    var method:      HTTPMethod        { get }
    var path:        String            { get }
    var query:       [URLQueryItem]    { get }
    
    var headers:     [String : String] { get }
    var parameters:  Parameters?       { get }
    var requestBody: Data?             { get }
    
}

extension Router {
    
    public func asURLRequest() throws -> URLRequest {
        let urlString = String.init(format: "%@%@", self.baseURL, self.path)
        
        var urlComponents = URLComponents(string: urlString)!
        urlComponents.queryItems = self.query
        
        urlComponents.percentEncodedQuery = urlComponents.percentEncodedQuery?.replacingOccurrences(of: "+",
                                                                                                    with: "%2B")
        
        var request = URLRequest.init(url: urlComponents.url!,
                                      cachePolicy: .reloadIgnoringLocalCacheData,
                                      timeoutInterval: self.timeout)
        
        request.httpMethod = self.method.rawValue
        
        request.allHTTPHeaderFields = self.headers
        
        request.httpBody = self.requestBody
        
        return request
    }
    
}
