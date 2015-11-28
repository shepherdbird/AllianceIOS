//
//  Global.swift
//  AllianceIOS
//
//  Created by dawei on 15/11/18.
//
//

import Foundation
import JSONJoy
let URL="http://183.129.190.82:50001/v1"
let Phone="2"
class Flag {
    var flag:Int!
    var msg:String!
    init(_ decoder:JSONDecoder){
        flag=decoder["flag"].integer
        msg=decoder["msg"].string
    }
}