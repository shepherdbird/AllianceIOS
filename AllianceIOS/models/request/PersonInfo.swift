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
    var id:String!
    var phone:String!
    var pwd:String!
    var authkey:String!
    var fatherid:String!
    var directalliancecount:String!
    var allalliancecount:String!
    var corns:String!
    var money:String!
    var envelope:String!
    var cornsforgrab:String!
    var alliancerewards:String!
    var nickname:String!
    var thumb:String!
    var gender:String!
    var area:String!
    var job:String!
    var hobby:String!
    var signature:String!
    var created_at:String!
    var updated_at:String!
    var channel:String?
    var platform:String?
    var friendcount:String!
    var concerncount:String!
    var isdraw:String!
    var status:String!
    var background:String!
    var invitecode:String!
    var huanxinid:String!
    
    
    init(_ decoder:JSONDecoder){
        id=decoder["id"].string
        phone=decoder["phone"].string
        pwd=decoder["pwd"].string
        authkey=decoder["authKey"].string
        fatherid=decoder["fatherid"].string
        directalliancecount=decoder["directalliancecount"].string
        allalliancecount=decoder["allalliancecount"].string
        corns=decoder["corns"].string
        money=decoder["money"].string
        envelope=decoder["envelope"].string
        cornsforgrab=decoder["cornsforgrab"].string
        alliancerewards=decoder["alliancerewards"].string
        nickname=decoder["nickname"].string
        thumb=decoder["thumb"].string
        gender=decoder["gender"].string
        area=decoder["area"].string
        job=decoder["job"].string
        hobby=decoder["hobby"].string
        signature=decoder["signature"].string
        created_at=decoder["created_at"].string
        updated_at=decoder["updated_at"].string
        channel=decoder["channel"].string
        platform=decoder["platform"].string
        concerncount=decoder["concerncount"].string
        friendcount=decoder["friendcount"].string
        isdraw=decoder["isdraw"].string
        status=decoder["status"].string
        background=decoder["background"].string
        invitecode=decoder["invitecode"].string
        huanxinid=decoder["huanxinid"].string
        
    }
}
