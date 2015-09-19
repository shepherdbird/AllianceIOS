//
//  UserModel.swift
//  AllianceIOS
//
//  Created by dawei on 15/9/17.
//
//
import Foundation
public class UserModel: NSObject {
    
    public var userId : String!
    
    public var userName:String!
    
    public var userAvator:String!
    
    /**
    * 用户所属状态<br>
    *
    * 我的好友         1<br>
    * 对我发出邀请的    2<br>
    * 我发出好友邀请的  3<br>
    * 未知            4<br>
    * 手机号好友       5<br>
    * 群聊            10<br>
    */
    public var userStatus = 1
    
    
    
    public override init() {
        super.init()
    }
    
    public init(userId:String,userName:String,userAvator:String?,userStatus:Int) {
        
        super.init()
        
        self.userId = userId
        self.userName = userName
        self.userAvator = userAvator!
        self.userStatus = userStatus
    }
    
    public func toString() ->String{
        
        let str1:String! = "userId    = " + self.userId + "userName= " + self.userName
        let str2:String! = "userAvator= " + self.userAvator + "userStatus= " + self.userStatus.description
        
        return str1 + str2
    }
    
}