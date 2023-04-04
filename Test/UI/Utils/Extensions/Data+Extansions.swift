//
//  Data+Extansions.swift
//  DashBoardManagment
//
//  Created by muslim mirzajonov on 05/05/22.
//


import Foundation
extension Data{
    mutating func append(string: String) {
       let data = string.data(
           using: String.Encoding.utf8,
           allowLossyConversion: true)
       append(data!)
     }
    
    
    var hexString: String {
        let hexString = map { String(format: "%02.2hhx", $0) }.joined()
        return hexString
    }
    
}

extension Date {
    var millisecondsSince1970:Int64 {
        Int64((self.timeIntervalSince1970 * 1000.0).rounded())
    }
    
    init(milliseconds:Int64) {
        self = Date(timeIntervalSince1970: TimeInterval(milliseconds) / 1000)
    }
}

