//
//  Utils.swift
//  PayUUPIBoltSwiftSampleApp
//
//  Created by Umang Arya on 19/03/20.
//  Copyright © 2020 PayU Payments Pvt Ltd. All rights reserved.
//

import CommonCrypto
import Foundation

class Utils {
    
    class func txnId() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyMMddHHmmss"
        let txnID = "iOS" + formatter.string(from: Date())
        return txnID
    }
}
