//
//  Global.swift
//  AllianceIOS
//
//  Created by dawei on 15/11/18.
//
//

import Foundation
import JSONJoy
let URL="http://183.129.190.82:50001/v1"
let Phone="2"
class Flag {
    var flag:Int!
    var msg:String!
    var c:Int?
    init(_ decoder:JSONDecoder){
        flag=decoder["flag"].integer
        msg=decoder["msg"].string
        c=decoder["c"].integer
    }
}
func TimeAgo(time:Int64)->String{
    let now=NSDate().timeIntervalSince1970
    let cha=Int64(now)-time
    var ans="0分钟前"
    if(cha<60){
        ans=String(cha)+"秒前"
    }else if(cha<60*60){
        ans=String(cha/60)+"分钟前"
    }else if(cha<60*60*24){
        ans=String(cha/60/60)+"小时前"
    }else if(cha<60*60*24*7){
        ans=String(cha/60/60/24)+"天前"
    }else if(cha<60*60*24*7*4){
        ans=String(cha/60/60/24/7)+"周前"
    }else{
        let format = NSDateFormatter()
        format.dateFormat="yy/MM/dd"
        let begin = NSDate(timeIntervalSince1970: Double(time))
        ans=format.stringFromDate(begin)
    }
    return ans
}
func GetBounds(width:CGFloat,height:CGFloat,font:UIFont,str:String)->CGRect{
    let content=NSString(string: str)
    let options : NSStringDrawingOptions = unsafeBitCast(NSStringDrawingOptions.UsesLineFragmentOrigin.rawValue |
        NSStringDrawingOptions.UsesFontLeading.rawValue,
        NSStringDrawingOptions.self)
    let boundingRect = content.boundingRectWithSize(CGSizeMake(width, height), options: options, attributes: [NSFontAttributeName:font], context: nil)
    return boundingRect
}