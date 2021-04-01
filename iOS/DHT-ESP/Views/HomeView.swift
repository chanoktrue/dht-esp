//
//  Home.swift
//  DHT-ESP
//
//  Created by Thongchai Subsaidee on 31/3/2564 BE.
//

import SwiftUI

struct HomeView: View {
    var page: PagesModel
    @ObservedObject var weatherVM = WeatherViewModel()
    
    var body: some View {
        ZStack {
            HStack {
                VStack(alignment: .leading) {
                    HStack {
                        Text(weatherVM.weatherModes?.first?.main ?? "")
                            .font(.custom("Sukhumvit Set", size: 50))
                            .minimumScaleFactor(0.5)
                            .foregroundColor(.white)
                            .padding(.vertical, 8)
                        
                        Spacer()
                        
                        Text(weatherVM.getVersion())
                            .font(.custom("Sukhumvit Set", size: 16))
                            .minimumScaleFactor(0.5)
                            .foregroundColor(.white)
                            .padding(.vertical, 8)
                    }
                    
                    Text(weatherVM.weatherModes?.first?.description ?? "")
                        .font(.custom("Sukhumvit Set", size: 20))
                        .foregroundColor(.white)
                    
                    let c = (weatherVM.weatherModes?.first?.temp ?? 0.0) - 273
                    Text(String(format: "%.2f", c) + " ℃")
                        .font(.custom("Sukhumvit Set", size: 20))
                        .foregroundColor(.white)
                    
                    Spacer()
                }
                
                Spacer()
            }
            .padding()
            
            VStack {
                
                Text(topicsData[0])
                    .font(.custom("Sukhumvit set", size: 20))
                    .minimumScaleFactor(0.5)
                    .foregroundColor(.white)
                    
                
                HStack(alignment: .top) {
                        Text(weatherVM.temp)
                            .font(.custom("Sukhuvit Set", size: 110))
                            .foregroundColor(.white)
                            .minimumScaleFactor(0.5)
                            .animation(.linear(duration: 0.5))
                        Text("°")
                            .font(.custom("Sukhuvit Set", size: 50))
                            .foregroundColor(.white)
                            .animation(.linear(duration: 0.5))
                            .padding(.trailing, 5)
                }
                
                HStack {
                    Spacer()
                    HStack {
                    Text(weatherVM.humi )
                        .font(.custom("Sukhuvit Set", size: 50))
                        .foregroundColor(.white)
                        .animation(.linear(duration: 0.8))
                        .padding()
                        Text("%")
                            .font(.custom("Sukhuvit Set", size: 30))
                            .foregroundColor(.white)
                            .animation(.linear(duration: 0.5))
                            .padding(.trailing, 10)
                    }
                }
            }
            
        }
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
        .background(LinearGradient(
                        gradient: Gradient(colors: weatherVM.gradientColors),
                        startPoint: .top,
                        endPoint: .bottom))
        .cornerRadius(20)
        .padding(.horizontal, 20)
        .padding(.vertical, 10)
        .shadow(color: Color.gray.opacity(0.5), radius: 5, x: 0, y: 0)
        .onAppear{
            weatherVM.getWeather()
        }
        .onReceive(NotificationCenter.default.publisher(for: UIApplication.didBecomeActiveNotification)) { (_) in
            weatherVM.getWeather()
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(page: pagesData[0])
    }
}
