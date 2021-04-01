//
//  WeatherViewModel.swift
//  DHT-ESP
//
//  Created by Thongchai Subsaidee on 31/3/2564 BE.
//

import SwiftUI

class WeatherViewModel: ObservableObject {
    
    @Published var weatherModes: [WeatherModel]?
    @Published var messageModels: [MessageModel] = []
    @Published var dhtModel: DHTModel = DHTModel()
    
    @Published var temp: String = "-"
    @Published var humi: String = "-"
    @Published var gradientColors: [Color] = [Color("ColorBlueberryLight"), Color("ColorBlueberryDark")]
    
    init() {
        getMqtt()
        getVersion()
    }
    
    
    func getVersion() -> String {
        let dictionary = Bundle.main.infoDictionary!
        let version = dictionary["CFBundleShortVersionString"] as! String
        let build = dictionary["CFBundleVersion"] as! String
        return "Ver \(version) build \(build)"
    }
    
    func getData() {
        if let temp = messageModels.filter({$0.topic == topicsData[0]}).first?.temp {
            self.temp = temp
            self.setBackgrounColor(temp: temp)
        }
        
        if let humi = messageModels.filter({$0.topic ==  topicsData[1]}).first?.temp {
            self.humi = humi
        }
    }
    
    func setBackgrounColor(temp: String) {
        let temp = Double(temp) ?? 0.0
//        let temp = 26.0
        if temp > 30.0 {
            self.gradientColors = [Color("ColorAppleLight"), Color("ColorStrawberryLight"), Color("ColorAppleDark")]
        }else if temp > 27 {
            self.gradientColors = [Color("ColorBlueberryLight"), Color("ColorBlueberryDark"),Color("ColorPlumDark")]
        }else if temp > 25 {
            self.gradientColors = [Color("ColorBlueberryLight"), Color("ColorBlueberryDark")]
        }else {
            self.gradientColors = [Color("ColorBlueberryLight"), Color("ColorBlueberryDark")]
        }
    }
    
    
    func getWeather() {
        getMqtt()
        APIService.getWeather { (weatherModels) in
            self.weatherModes = weatherModels
        }
    }
    
    func getMqtt() {
        MQTTService.shared.setupMQTT()
        MQTTService.shared.mqttSubscribe(topics: topicsData)
        MQTTService.shared.mqttMessage { (message) in
            
            print(message)

            if let topic = message?.topic, let payloads = message?.payload {
                let found = self.messageModels.filter({$0.topic == topic})
                let temp = String(bytes: payloads, encoding: .utf8)
                if found.count == 0 {
                    self.messageModels.append(MessageModel(topic: topic, payloads: payloads, temp: temp))
                }else {
                    self.messageModels.filter({$0.topic == topic}).first?.temp = temp
                }
                self.getData()
            }
            
        }

    }
    
    
}

