//
//  ChartView.swift
//  DHT-ESP
//
//  Created by Thongchai Subsaidee on 2/4/2564 BE.
//

import SwiftUI
import Charts

struct ChartView: UIViewRepresentable {
    
    var entries: [BarChartDataEntry] = []
    
    func makeUIView(context: Context) -> BarChartView {
        let chart = BarChartView()
        return chart
    }
    
    func updateUIView(_ uiView: BarChartView, context: Context) {
        
    }
}

extension ChartView {
    func setUpChart() {
        
    }
}


//extension ChartView {
//
//    func setUpChart() {
//        lineChart.noDataText = "ไม่มีข้อมูล"
//        let dataSets = [getLineChartDataSet()]
//        let data = LineChartData(dataSets: dataSets)
//        data.setValueFont(.systemFont(ofSize: 7, weight: .light))
//        lineChart.data = data
//    }
//
//    // create dataSets
//    func getLineChartDataSet() -> LineChartDataSet {
//        let dataPoints = getChartDataPoints(sessions: [0,1,2,3,4,5], accuracy: [100.0, 20.0, 30.0, 100.0, 20.0, 30.0])
//        let set = LineChartDataSet(entries: dataPoints, label: "DataSet")
//        set.lineWidth = 2.5
//        set.circleRadius = 4
//        set.circleHoleRadius = 2
//        let color = ChartColorTemplates.vordiplom()[0]
//        set.setColor(color)
//        set.setCircleColor(color)
//        return set
//
//    }
//
//    func getChartDataPoints(sessions: [Int], accuracy: [Double]) -> [ChartDataEntry] {
//        var dataPoints: [ChartDataEntry] = []
//        for count in (0..<sessions.count) {
//            dataPoints.append(ChartDataEntry.init(x: Double(sessions[count]), y: accuracy[count]))
//        }
//        return dataPoints
//    }
//    //: Create dataSets
//
//
//
//}


