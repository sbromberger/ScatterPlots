//
//  ViewController.swift
//  ScatterPlots
//
//  Created by Seth Bromberger on 2018-05-31.
//  Copyright © 2018 Seth Bromberger. All rights reserved.
//

import Cocoa
import Charts

class ViewController: NSViewController {
    @IBOutlet var scatterChartView: ScatterChartView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let points = (1...200).map { _ -> ChartDataEntry in
            return ChartDataEntry(x: Double(arc4random() % 200), y: Double(arc4random() % 200))
            
        }
        
        let data = ScatterChartData()
        let chartData = ScatterChartDataSet(values: points)
        chartData.colors = [NSUIColor.red]
        chartData.setScatterShape(.circle)
        data.addDataSet(chartData)
        self.scatterChartView.data = data
        self.scatterChartView.gridBackgroundColor = NSUIColor.clear
        self.scatterChartView.rightAxis.enabled = false
        self.scatterChartView.leftAxis.drawGridLinesEnabled = false
        self.scatterChartView.xAxis.drawGridLinesEnabled = false
        self.scatterChartView.xAxis.labelPosition = .bottom
        // Do any additional setup after loading the view.
    }

    @IBAction func saveDocument(_ sender: AnyObject) {
        let panel = NSSavePanel()
        panel.allowedFileTypes = ["png"]
        panel.beginSheetModal(for: self.view.window!) { (result) -> Void in
            if result.rawValue == NSApplication.ModalResponse.OK.rawValue {
                if let path = panel.url?.path {
                    let _ = self.scatterChartView.save(to: path, format: .png, compressionQuality: 1.0)
                }
            }
        }
    }
    
    private func readCSV(fileName: String) -> [ChartDataEntry] {
        let furl = URL(fileURLWithPath: fileName)
        var points = [ChartDataEntry]()
        do {
            let s = try String(contentsOf: furl)
            let lines = s.split(separator: "\n")
            for line in lines {
                let splits = line.split(separator: ",", maxSplits: 2)
                let x = Double(splits[0])!
                let y = Double(splits[1])!
                points.append(ChartDataEntry(x: x, y: y))
            }
        } catch {
            print("error processing file \(fileName): \(error)")
        }
        
        return points
    }

    @IBAction func openDocument(_ sender: AnyObject) {
        let panel = NSOpenPanel()
        panel.allowedFileTypes = ["csv"]
        panel.beginSheetModal(for: self.view.window!) { (result) -> Void in
            if result.rawValue == NSApplication.ModalResponse.OK.rawValue {
                if let path = panel.url?.path {
                    let newPoints = self.readCSV(fileName: path)
                    let data = ScatterChartData()
                    let chartData = ScatterChartDataSet(values: newPoints)
                    chartData.colors = [NSUIColor.red]
                    chartData.setScatterShape(.circle)
                    data.addDataSet(chartData)
                    self.scatterChartView.data = data
                }
            }
        }
    }
    
    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }


}

