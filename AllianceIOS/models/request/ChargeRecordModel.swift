//
//  ChargeRecord.swift
//  AllianceIOS
//
//  Created by dawei on 15/11/29.
//
//

import Foundation
import JSONJoy

class GrabCommodityRecord {
    var items: Array<GrabCommodityRecord_one>!
    var _links : Link!
    var _meta : Meta!
    init(_ decoder: JSONDecoder) {
        //we check if the array is valid then alloc our array and loop through it, creating the new address objects.
        if let it = decoder["items"].array {
            items = Array<GrabCommodityRecord_one>()
            for itemDecoder in it {
                items.append(GrabCommodityRecord_one(itemDecoder))
            }
        }
        
        _links = Link(decoder["_links"])
        _meta = Meta(decoder["_meta"])
    }
}
class GrabCommodityRecord_one {
    var id:Int!
    var userid:Int!
    var grabcommodityid:String?
    var grabcornid:String?
    var count:Int!
    var numbers:String!
    var type:Int!
    var created_at:Int!
    var isgotback:Int!
    var isgot:String?
    var picture:String!
    var title:String!
    var version:String!
    var needed:Int!
    //var remain:Int!
    
    var date:String!
    var end_at:String!
    var islotteried:Int!
    var winnernumber:String?
    
    var winnercount:String?
    var phone:String?
    var nickname:String?
    var thumb:String?
    
    var flag:String?
    init(_ decoder:JSONDecoder){
        id=Int(decoder["id"].string!)
        userid=Int(decoder["userid"].string!)
        grabcommodityid=decoder["grabcommodityid"].string
        grabcornid=decoder["grabcornid"].string
        count=Int(decoder["count"].string!)
        picture=decoder["picture"].string
        numbers=decoder["numbers"].string
        type=Int(decoder["type"].string!)
        isgotback=Int(decoder["isgotback"].string!)
        isgot=decoder["isgot"].string
        title=decoder["title"].string
        version=decoder["version"].string
        needed=Int(decoder["needed"].string!)
        //remain=Int(decoder["remain"].string!)
        created_at=Int(decoder["created_at"].string!)
        date=decoder["date"].string
        end_at=decoder["end_at"].string
        islotteried=Int(decoder["islotteried"].string!)
        winnercount=decoder["winnercount"].string
        phone=decoder["phone"].string
        winnernumber=decoder["winnernumber"].string
        nickname=decoder["nickname"].string
        thumb=decoder["thumb"].string
        flag=decoder["flag"].string
    }
    
}