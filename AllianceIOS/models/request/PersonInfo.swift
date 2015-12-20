//
//  PersonInfo.swift
//  AllianceIOS
//
//  Created by dawei on 15/12/15.
//
//

import Foundation
import JSONJoy
class PersonInfo {
    var id:Int!
    var phone:String!
    var pwd:String!
    var authkey:String!
    var fatherid:String!
    var directalliancecount:Int!
    var allalliancecount:Int!
    var corns:Int!
    var money:Int!
    var envelope:Int!
    var cornsforgrab:Int!
    var alliancerewards:Int!
    var nickname:String!
    var thumb:String!
    var gender:Int!
    var area:String!
    var job:String!
    var hobby:String!
    var signature:String!
    var created_at:Int!
    var updated_at:Int!
    var channel:String?
    var platform:String?
    var friendcount:Int!
    var concerncount:Int!
    var isdraw:Int!
    var status:Int!
    
    
    init(_ decoder:JSONDecoder){
        id=decoder["id"].integer
        phone=decoder["phone"].string
        pwd=decoder["pwd"].string
        authkey=decoder["authKey"].string
        fatherid=decoder["fatherid"].string
        directalliancecount=decoder["directalliancecount"].integer
        allalliancecount=decoder["allalliancecount"].integer
        corns=decoder["corns"].integer
        money=decoder["money"].integer
        envelope=decoder["envelope"].integer
        cornsforgrab=decoder["cornsforgrab"].integer
        alliancerewards=decoder["alliancerewards"].integer
        nickname=decoder["nickname"].string
        thumb=decoder["thumb"].string
        gender=decoder["gender"].integer
        area=decoder["area"].string
        job=decoder["job"].string
        hobby=decoder["hobby"].string
        signature=decoder["signature"].string
        created_at=decoder["created_at"].integer
        updated_at=decoder["updated_at"].integer
        channel=decoder["channel"].string
        platform=decoder["platform"].string
        concerncount=decoder["concerncount"].integer
        friendcount=decoder["friendcount"].integer
        isdraw=decoder["isdraw"].integer
        status=decoder["status"].integer
        
    }
}
