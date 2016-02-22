//
//  Card.swift
//  AllianceIOS
//
//  Created by dawei on 16/1/16.
//
//
import Foundation
import JSONJoy
class Card {
    var id:Int!
    var userid:Int!
    var cardnumber:String?
    var name:String?
    var idcard:String?
    var lphone:String?
    var location:String?
    
    
    init(_ decoder:JSONDecoder){
        id=decoder["id"].integer
        userid=decoder["userid"].integer
        cardnumber=decoder["cardnumber"].string
        name=decoder["name"].string
        idcard=decoder["idcard"].string
        lphone=decoder["lphone"].string
        location=decoder["location"].string
    }
}
class Cards{
    var items:Array<Card>!
    init(_ decoder: JSONDecoder) {
        //we check if the array is valid then alloc our array and loop through it, creating the new address objects.
        if let it = decoder.array {
            items = Array<Card>()
            for itemDecoder in it {
                items.append(Card(itemDecoder))
            }
        }
    }
}