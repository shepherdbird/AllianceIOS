//
//  Qiniutoken.swift
//  AllianceIOS
//
//  Created by xufei on 15/11/27.
//
//

import Foundation
import SwiftHTTP
import JSONJoy

class Qiniutoken{
    
    struct Item : JSONJoy {
        var token: String?
        init(_ decoder: JSONDecoder) {
            token=decoder["token"].string
        }
    }
}