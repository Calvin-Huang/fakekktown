//
//  Category.swift
//  CarouselPratice
//
//  Created by Calvin on 6/15/16.
//  Copyright © 2016 CapsLock. All rights reserved.
//

import Foundation

import ObjectMapper

struct Category: Mappable {
    var title: String?
    var icon: String?
    
    init?(_ map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        title <- map["title"]
        icon <- map["icon"]
    }
}