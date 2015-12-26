//
//  AllMoney.swift
//  AllianceIOS
//
//  Created by dawei on 15/12/21.
//
//

import Foundation
import JSONJoy
class AllMoney {
    var cardcount:String!
    var money:Int!
    var corns:Int!
    var cornsforgrab:Int!
    
    
    init(_ decoder:JSONDecoder){
        cardcount=decoder["cardcount"].string
        money=decoder["money"].integer
        corns=decoder["corns"].integer
        cornsforgrab=decoder["cornsforgrab"].integer
    }
}