//
//  LiaoBaUser.swift
//  AllianceIOS
//
//  Created by dawei on 15/11/20.
//
//

import Foundation
import JSONJoy
class LiaoBaUser {
    var phone:String!
    var nickname:String!
    var signature:String!
    var concerncount:String!
    var isconcerned:String!
    var friendcount:String!
    var thumb:String!
    init(_ decoder:JSONDecoder){
        phone=decoder["phone"].string
        nickname=decoder["nickname"].string
        signature=decoder["signature"].string
        concerncount=decoder["concerncount"].string
        isconcerned=decoder["isconcerned"].string
        friendcount=decoder["friendcount"].string
        thumb=decoder["thumb"].string
    }
}
class LiaobaFans{
    var items:Array<LiaoBaUser>!
    var _links : Link!
    var _meta : Meta!
    init(_ decoder:JSONDecoder){
        if let it = decoder["items"].array {
            items = Array<LiaoBaUser>()
            for itemDecoder in it {
                items.append(LiaoBaUser(itemDecoder))
            }
        }
        
        _links = Link(decoder["_links"])
        _meta = Meta(decoder["_meta"])
    }
}