//
//  CFSocketGetLocationModel.swift
//  AmapDemo
//
//  Created by 温天浩 on 2020/8/27.
//  Copyright © 2020 CF. All rights reserved.
//

import UIKit
import ObjectMapper

class CFSocketGetLocationModel: Mappable {

    var orderId: String = ""
    var location: String = ""

    required init?(map: Map) {
       
    }
    
    func mapping(map: Map) {
       
        orderId  <-  map["orderId"]
        location  <-  map["location"]
       
    }
    
}
