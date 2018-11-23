//
//  Error+FireWrapper.swift
//  Glosso
//
//  Created by sequenia on 08/11/2018.
//  Copyright © 2018 Sequenia. All rights reserved.
//

import Alamofire

enum ErrorType: String {
    case noConnection   = "fire_wrapper_no_connection_error"
    case slowConnection = "fire_wrapper_slow_connection_error"
    case invalidFormat  = "fire_wrapper_invalid_format_error"
    case internalServer = "fire_wrapper_internal_server_error"
}

extension Error {
    
    func fw_errorMessage() -> ErrorType {
        if self._code == NSURLErrorTimedOut {
            return .slowConnection
        }
        else if self._code == NSURLErrorCannotFindHost ||
            self._code == NSURLErrorNetworkConnectionLost ||
            self._code == NSURLErrorNotConnectedToInternet ||
            self._code == NSURLErrorCannotConnectToHost {
            return .noConnection
        }
        return .internalServer
    }
    
}
