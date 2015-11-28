//
//  grabcommodity_getthree.swift
//  AllianceIOS
//
//  Created by dawei on 15/11/19.
//
//

import Foundation
import JSONJoy
class GrabCommodity_getthree_one {
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
    }
    
}
class GrabCommodity_getthree {
    var items:Array<GrabCommodity_getthree_one>!
    init(_ decoder:JSONDecoder){
        if let it=decoder.array{
            items=Array<GrabCommodity_getthree_one>()
            for itemDecoder in it{
                items.append(GrabCommodity_getthree_one(itemDecoder))
            }
        }
    }
}
class GrabCommodityList {
    var items: Array<GrabCommodity_getthree_one>!
    var _links : Link!
    var _meta : Meta!
    init(_ decoder: JSONDecoder) {
        //we check if the array is valid then alloc our array and loop through it, creating the new address objects.
        if let it = decoder["items"].array {
            items = Array<GrabCommodity_getthree_one>()
            for itemDecoder in it {
                items.append(GrabCommodity_getthree_one(itemDecoder))
            }
        }
        
        _links = Link(decoder["_links"])
        _meta = Meta(decoder["_meta"])
    }
}