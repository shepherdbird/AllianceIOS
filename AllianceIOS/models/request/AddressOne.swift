//
//  AddressOne.swift
//  AllianceIOS
//
//  Created by dawei on 15/12/20.
//
//

import Foundation
import JSONJoy
class AddressOne {
    var id:Int!
    var userid:Int!
    var name:String!
    var address:String!
    var aphone:String!
    var postcode:String!
    var created_at:Int!
    var isdefault:Int!
    
    
    init(_ decoder:JSONDecoder){
        id=decoder["id"].integer
        userid=decoder["userid"].integer
        name=decoder["name"].string
        address=decoder["address"].string
        aphone=decoder["aphone"].string
        postcode=decoder["postcode"].string
        isdefault=decoder["isdefault"].integer
        created_at=decoder["created_at"].integer
    }
}
class Addresses{
    var items:Array<AddressOne>!
    init(_ decoder:JSONDecoder){
        if let it = decoder.array {
            items = Array<AddressOne>()
            for itemDecoder in it {
                items.append(AddressOne(itemDecoder))
            }
        }
    }
}
