//
//  LiaoBa.swift
//  AllianceIOS
//
//  Created by dawei on 15/11/19.
//
//

import Foundation
import JSONJoy
class ChatMessageList {
    var items: Array<ChatMessage>!
    var _links : Link!
    var _meta : Meta!
    init(_ decoder: JSONDecoder) {
        //we check if the array is valid then alloc our array and loop through it, creating the new address objects.
        if let it = decoder["items"].array {
            items = Array<ChatMessage>()
            for itemDecoder in it {
                items.append(ChatMessage(itemDecoder))
            }
        }
        
        _links = Link(decoder["_links"])
        _meta = Meta(decoder["_meta"])
    }
}

class ChatMessage {
    var id:String!
    var userid:String!
    var content:String!
    var pictures:String!
    var likecount:String?
    var replycount:String?
    var created_at:String!
    var phone:String!
    var title:String?
    var iszaned:String?
    var iscollected:String?
    var ismy:Int?
    var nickname:String!
    var thumb:String!
    var isconcerned:String!
    var isliked:String!
    var replys:Array<ChatMessageReply>!
    var likes:Array<ChatMessageLike>!
    init(_ decoder:JSONDecoder){
        id=decoder["id"].string
        userid=decoder["userid"].string
        content=decoder["content"].string
        pictures=decoder["pictures"].string
        likecount=decoder["likecount"].string
        replycount=decoder["replycount"].string
        created_at=decoder["created_at"].string
        title=decoder["title"].string
        iszaned=decoder["iszaned"].string
        iscollected=decoder["iscollected"].string
        ismy=decoder["ismy"].integer
        phone=decoder["phone"].string
        nickname=decoder["nickname"].string
        thumb=decoder["thumb"].string
        isconcerned=decoder["isconcerned"].string
        isliked=decoder["isliked"].string
        if let it = decoder["replys"].array {
            replys = Array<ChatMessageReply>()
            for itemDecoder in it {
                replys.append(ChatMessageReply(itemDecoder))
            }
        }
        if let it = decoder["likes"].array {
            likes = Array<ChatMessageLike>()
            for itemDecoder in it {
                likes.append(ChatMessageLike(itemDecoder))
            }
        }
    }
}
class ChatMessageReply {
    var id:String!
    var tbmessageid:String?
    var messageid:String?
    var content:String!
    var fromid:String!
    var toid:String!
    var isread:String!
    var created_at:String!
    var fromnickname:String!
    var fromphone:String!
    var fromthumb:String?
    var tothumb:String?
    var tonickname:String!
    var tophone:String!
    init(_ decoder: JSONDecoder){
        id=decoder["id"].string
        tbmessageid=decoder["tbmessageid"].string
        messageid=decoder["messageid"].string
        content=decoder["content"].string
        fromid=decoder["fromid"].string
        toid=decoder["toid"].string
        isread=decoder["isread"].string
        created_at=decoder["created_at"].string
        fromnickname=decoder["fromnickname"].string
        fromphone=decoder["fromphone"].string
        fromthumb=decoder["fromthumb"].string
        tothumb=decoder["tothumb"].string
        tonickname=decoder["tonickname"].string
        tophone=decoder["tophone"].string
    }
}
class ReplyMore{
    var items:Array<ChatMessageReply>!
    var _links : Link!
    var _meta : Meta!
    init(_ decoder: JSONDecoder) {
        //we check if the array is valid then alloc our array and loop through it, creating the new address objects.
        if let it = decoder["items"].array {
            items = Array<ChatMessageReply>()
            for itemDecoder in it {
                items.append(ChatMessageReply(itemDecoder))
            }
        }
        
        _links = Link(decoder["_links"])
        _meta = Meta(decoder["_meta"])
    }
}
class ChatMessageLike {
    var phone:String!
    var nickname:String!
    var thumb:String?
    init(_ decoder: JSONDecoder){
        phone=decoder["phone"].string
        nickname=decoder["nickname"].string
        thumb=decoder["thumb"].string
    }
}
class ChatPopularityOne {
    var phone:String!
    var nickname:String!
    var signature:String!
    var concerncount:String!
    var isconcerned:String!
    var thumb:String!
    init(_ decoder:JSONDecoder){
        phone=decoder["phone"].string
        nickname=decoder["nickname"].string
        concerncount=decoder["concerncount"].string
        isconcerned=decoder["isconcerned"].string
        signature=decoder["signature"].string
        thumb=decoder["thumb"].string
    }
}
class ChatPopularityList {
    var items:Array<ChatPopularityOne>!
    var _links : Link!
    var _meta : Meta!
    init(_ decoder:JSONDecoder){
        if let it = decoder["items"].array {
            items = Array<ChatPopularityOne>()
            for itemDecoder in it {
                items.append(ChatPopularityOne(itemDecoder))
            }
        }
        
        _links = Link(decoder["_links"])
        _meta = Meta(decoder["_meta"])
    }
}