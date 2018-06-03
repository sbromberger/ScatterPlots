//
//  ScatterChart.swift
//  ScatterPlots
//
//  Created by Bromberger, Seth on 2018-06-02.
//  Copyright © 2018 Seth Bromberger. All rights reserved.
//

import Foundation
import Charts

class ScatterPlot {
    var dataSet : ScatterChartDataSet
    var data : ScatterChartData
    
    init() {
        let points = (1...200).map { _ -> ChartDataEntry in
            return ChartDataEntry(x: Double(arc4random() % 200), y: Double(arc4random() % 200))
        }
        dataSet = ScatterChartDataSet(values: points)
        dataSet.colors = [NSUIColor.red]
        dataSet.setScatterShape(.circle)
        data = ScatterChartData()
        data.addDataSet(dataSet)
    }
    
}
