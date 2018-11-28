//
//  String+FireWrapper.swift
//  FireWrapper
//
//  Created by sequenia on 27/11/2018.
//  Copyright © 2018 Sequenia. All rights reserved.
//

import UIKit

extension String {
    
    public var fw_localized: String {
        let bundle = Bundle.init(for: NetworkHelper.self)
        let res =  bundle.localizedString(forKey: self, value: "", table: "FWLocalizable")
        return res
    }
    
}
