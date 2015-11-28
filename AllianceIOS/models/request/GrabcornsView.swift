//
//  GrabcornsView.swift
//  AllianceIOS
//
//  Created by dawei on 15/11/18.
//
//

import Foundation
import JSONJoy
class GrabcornsView {
    var detail:Grabcorns_getthree_one!
    var records : Array<Record>!
    var myrecords : Array<Record>!
    init(_ decoder: JSONDecoder) {
        //we check if the array is valid then alloc our array and loop through it, creating the new address objects.
        detail=Grabcorns_getthree_one(decoder["detail"])
        if let it = decoder["records"].array {
            records = Array<Record>()
            for itemDecoder in it {
                records.append(Record(itemDecoder))
            }
        }
        if let it = decoder["myrecords"].array {
            myrecords = Array<Record>()
            for itemDecoder in it {
                myrecords.append(Record(itemDecoder))
            }
        }
        
    }
}
class Record {
    var count:String!
    var type:String!
    var nickname:String!
    var thumb:String!
    var created_at:String!
    var phone:String!
    //一元夺宝专有
    var id:String!
    var userid:String!
    var grabcommodityid:String!
    var numbers:String!
    init(_ decoder:JSONDecoder){
        count=decoder["count"].string!
        type=decoder["type"].string!
        nickname=decoder["nickname"].string!
        thumb=decoder["thumb"].string!
        created_at=decoder["created_at"].string!
        phone=decoder["phone"].string!
        //一元夺宝
        id=decoder["id"].string
        userid=decoder["userid"].string
        grabcommodityid=decoder["grabcommodityid"].string
        numbers=decoder["numbers"].string
    }
}
