//
//  PayloadModal.swift
//  DHT-ESP
//
//  Created by Thongchai Subsaidee on 31/3/2564 BE.
//

import Foundation

class MessageModel {
    var topic: String?
    var payloads: [UInt8]?
    var temp: String?
    
    init(topic: String?, payloads: [UInt8]?, temp: String?) {
        self.topic = topic
        self.payloads = payloads
        self.temp = temp
    }
}
