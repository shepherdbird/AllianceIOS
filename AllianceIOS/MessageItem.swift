//
//  MessageItem.swift
//  AllianceIOS
//
//  Created by dawei on 15/9/23.
//
//

import Foundation
class MessageItem
{
    //头像
    var avatar:String
    //消息时间
    var date:NSDate
    //消息内容
    var content:String
    var from:String
    var to:String
    init(avatar:String,date:NSDate,content:String,from:String,to:String){
        self.date=date
        self.avatar=avatar
        self.content=content
        self.from=from
        self.to=to
    }
}
