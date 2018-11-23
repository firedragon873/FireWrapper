//
//  NetworkHelper.swift
//  Glosso
//
//  Created by sequenia on 08/11/2018.
//  Copyright © 2018 Sequenia. All rights reserved.
//

import UIKit

public class NetworkHelper: NSObject {

    static private var numberOfCallsIndicator: Int = 0
    
    static public func setActivityIndicatorVisibility(_ visible: Bool) {
        if visible {
            numberOfCallsIndicator += 1
        }
        else {
            numberOfCallsIndicator -= 1
        }
        if numberOfCallsIndicator < 0 {
            numberOfCallsIndicator = 0
        }
        
        UIApplication.shared.isNetworkActivityIndicatorVisible = numberOfCallsIndicator > 0
    }
    
}
