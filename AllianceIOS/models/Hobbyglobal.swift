//
//  Hobbyglobal.swift
//  AllianceIOS
//
//  Created by xufei on 15/11/30.
//
//

import Foundation

import SwiftHTTP
import JSONJoy

class HobbyGlobal{
    struct Item : JSONJoy {
        var objID: Int?
        var hobby: String?
        init(_ decoder: JSONDecoder) {
            objID = decoder["id"].integer
            hobby=decoder["hobby"].string
        }
    }
    
    struct Hobby: JSONJoy {
        var items: Array<Item>!
        
        init(_ decoder: JSONDecoder) {
            //we check if the array is valid then alloc our array and loop through it, creating the new address objects.
            if let it = decoder.array {
                items = Array<Item>()
                for itemDecoder in it {
                    items.append(Item(itemDecoder))
                }
            }
        }
    }
}