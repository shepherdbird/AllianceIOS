//
//  GrabcornsList.swift
//  AllianceIOS
//
//  Created by dawei on 15/11/17.
//
//

import Foundation
import JSONJoy
class GrabcornsList {
    var items: Array<Grabcorns_getthree_one>!
    var _links : Link!
    var _meta : Meta!
    init(_ decoder: JSONDecoder) {
        //we check if the array is valid then alloc our array and loop through it, creating the new address objects.
        if let it = decoder["items"].array {
            items = Array<Grabcorns_getthree_one>()
            for itemDecoder in it {
                items.append(Grabcorns_getthree_one(itemDecoder))
            }
        }
        
        _links = Link(decoder["_links"])
        _meta = Meta(decoder["_meta"])
    }
}
class Url {
    var href:String?
    init(_ decoder: JSONDecoder) {
        href = decoder["href"].string
    }
}
class Link {
    var href:Url?
    var prev:Url?
    var next:Url?
    init(_ decoder: JSONDecoder) {
        href = Url(decoder["href"])
        prev = Url(decoder["prev"])
        next = Url(decoder["next"])
    }
}

class Meta {
    var totalCount: Int!
    var pageCount: Int!
    var currentPage: Int!
    var perPage: Int!
    init(_ decoder: JSONDecoder) {
        totalCount = decoder["totalCount"].integer!
        pageCount = decoder["pageCount"].integer!
        currentPage = decoder["currentPage"].integer!
        perPage = decoder["perPage"].integer!
    }
    
}