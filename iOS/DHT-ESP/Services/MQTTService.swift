//
//  MQTT.swift
//  Home
//
//  Created by Saijo Denki  on 8/4/20.
//  Copyright © 2020 canoktrue.com. All rights reserved.
//

import UIKit
import CocoaMQTT

class MQTTService {
    var mqtt: CocoaMQTT?
    var isConnect: Bool?
    
    init() {
        
    }
    
    static let shared = MQTTService()
}

extension MQTTService {
    
    func setupMQTT() {                
        let clientID = UUID().uuidString
        let host =  "homenano.trueddns.com"
        let port: UInt16 = 24347
        mqtt = CocoaMQTT(clientID: clientID, host: host, port: port)
        mqtt?.username = "roj"
        mqtt?.password = "123456"
        mqtt?.keepAlive = 60
        isConnect = mqtt?.connect()
    }
    
    func mqttSubscribe(topics: [String]) {
        mqtt?.didConnectAck = { mqtt, ack in
            if ack == .accept {
                for topic in topics {
                    mqtt.subscribe(topic)
                }
            }
        }        
    }
    
    func mqttMessage(completion: ((CocoaMQTTMessage?)->())?) {
        mqtt?.didReceiveMessage  = { mqtt, message, id in
            completion?(message)
        }
    }
}
