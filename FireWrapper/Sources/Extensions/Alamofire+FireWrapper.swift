//
//  Alamofire+FireWrapper.swift
//  Glosso
//
//  Created by sequenia on 08/11/2018.
//  Copyright © 2018 Sequenia. All rights reserved.
//

import Alamofire
import SwiftyJSON

public enum ResponseKey: String {
    case success = "success"
    case error   = "error"
    case errors  = "errors"
    case data    = "data"
}

extension Request {
    
    public func fw_debugLog(isDebug: Bool = false) -> Self {
        if isDebug {
            print("------------")
            debugPrint(self)
            print("------------")
        }
        return self
    }
    
}

extension DataRequest {
    public func fw_responseJSON(isDebug: Bool = false, completion: (@escaping (_ data: JSON?, _ error: String?, _ errors: [String : String]?, _ errorType: ErrorType?) -> Void )) {
        NetworkHelper.setActivityIndicatorVisibility(true)
        self.fw_debugLog(isDebug: isDebug).responseJSON { (response) in
            NetworkHelper.setActivityIndicatorVisibility(false)
            if isDebug {
                if let request = response.request {
                    if let url = request.url {
                        print("URL: \(url)")
                    }
                    if let headers = request.allHTTPHeaderFields {
                        print("Headers: \(headers)")
                    }
                    
                    if let body = request.httpBody {
                        print("Body: \(String.init(data: body, encoding: .utf8) ?? "undefined")")
                    }
                    
                }
                print("Response: \(response)")
                print("------------")
            }
            
            guard response.result.isSuccess,
                let value = response.result.value else {
                    let errorType = response.result.error?.fw_errorMessage() ?? ErrorType.internalServer
                    
                    print("Request failed with error: \(String(describing: response.result.error))")
                    
                    completion(nil, nil, nil, errorType)
                    return
            }
            
            let jsonResponse = JSON(value)
            
            guard jsonResponse[ResponseKey.success.rawValue].bool ?? false else {
                var errorType: ErrorType?
                var error: String?
                
                if let err = jsonResponse[ResponseKey.error.rawValue].string {
                    error = err
                }
                else {
                    errorType = ErrorType.internalServer
                }
                
                var errors: [String : String]? = nil
                
                if let errs = jsonResponse[ResponseKey.errors.rawValue].dictionaryObject as? [String : String] {
                    errors = errs
                }
                completion(nil, error, errors, errorType)
                return
            }
            completion(JSON(jsonResponse[ResponseKey.data.rawValue].object), nil, nil, nil)
        }
    }
}

