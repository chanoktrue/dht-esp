//
//  APIService.swift
//  DHT-ESP
//
//  Created by Thongchai Subsaidee on 31/3/2564 BE.
//

import Foundation

class APIService {

    static func getWeather(completion: (([WeatherModel]?)->())?) {
        let str = "https://api.openweathermap.org/data/2.5/weather?q=nonthaburi,th&appid=586c8b66fb7cfd8e996c77b17bb06b3b&lang=th"
        print(str)
        guard let url = URL(string: str) else {return}
        
       var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let config = URLSessionConfiguration.default
        let sessoin = URLSession(configuration: config, delegate: nil, delegateQueue: .main)
        
        sessoin.dataTask(with: request) { (data, response, error) in
            guard let data = data, error == nil, let response = response as? HTTPURLResponse else {return}
            
            if response.statusCode == 200 {
                do{

                    let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: AnyObject]

                    var array = [WeatherModel]()
                    var weatherMain = ""
                    var weatherDescription = ""
                    var weatherTemp = 0.0
                    
                    //temp
                    if let main = json?["main"] as? [String: AnyObject], let temp = main["temp"] as? Double {
                        weatherTemp = temp
                    }
                    
                    //main
                    let weathers = json?["weather"] as? Array<AnyObject>
                    weathers?.forEach({ (weather) in
                        if let main = weather["main"] as? String, let description = weather["description"] as? String {
                            weatherMain = main
                            weatherDescription = description
                        }
                    })
                    
                    let weather = WeatherModel(main: weatherMain, description: weatherDescription, temp: weatherTemp)
                    array.append(weather)
                    completion?(array)

                }catch{
                    print("error : \(response.statusCode) \(error.localizedDescription)")
                }
            }
            
        }.resume()
        
        
    }

}


