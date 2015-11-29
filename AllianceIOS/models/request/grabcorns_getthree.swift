//
//  grabcorns_getthree.swift
//  AllianceIOS
//
//  Created by dawei on 15/11/17.
//
//

import Foundation
import JSONJoy
class Grabcorns_getthree_one {
    var id:Int!
    var picture:String!
    var title:String!
    var version:String!
    var needed:Int!
    var remain:Int!
    var created_at:Int!
    var date:String!
    var end_at:String!
    var islotteried:Int!
    var winneruserid:Int!
    var winnerrecordid:Int!
    var winnernumber:Int!
    var foruser:String!
    var kind:String!
    var pictures:String!
    var details:String!
    var worth:String!
    var isgot:String!
    var phone:String!
    var nickname:String!
    var thumb:String!
    var numbers:String!
    var count:String!
    init(_ decoder:JSONDecoder){
        id=Int(decoder["id"].string!)
        picture=decoder["picture"].string
        title=decoder["title"].string
        version=decoder["version"].string
        needed=Int(decoder["needed"].string!)
        remain=Int(decoder["remain"].string!)
        created_at=Int(decoder["created_at"].string!)
        date=decoder["date"].string
        end_at=decoder["end_at"].string
        islotteried=Int(decoder["islotteried"].string!)
        winneruserid=Int(decoder["winneruserid"].string!)
        winnerrecordid=Int(decoder["winnerrecordid"].string!)
        winnernumber=Int(decoder["winnernumber"].string!)
        foruser=decoder["foruser"].string
        kind=decoder["kind"].string
        pictures=decoder["pictures"].string
        details=decoder["details"].string
        worth=decoder["worth"].string
        isgot=decoder["isgot"].string
        phone=decoder["phone"].string
        nickname=decoder["nickname"].string
        thumb=decoder["thumb"].string
        numbers=decoder["numbers"].string
        count=decoder["count"].string
    }
    
}
class Grabcorns_getthree {
    var items:Array<Grabcorns_getthree_one>!
    init(_ decoder:JSONDecoder){
        if let it=decoder.array{
            items=Array<Grabcorns_getthree_one>()
            for itemDecoder in it{
                items.append(Grabcorns_getthree_one(itemDecoder))
            }
        }
    }
}