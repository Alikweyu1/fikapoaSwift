//
//  AllTransactionViewController.swift
//  FikaPoaFraudDetection
//
//  Created by SOFTWARE on 24/03/2023.
//

import UIKit
import Charts
class AllTransactionViewController: UIViewController {
    
    @IBOutlet weak var chart1View: UIView!
    @IBOutlet weak var chartView2: UIView!
    
    @IBOutlet weak var chartViews3: UIView!
    @IBOutlet weak var chart3View: UIView!
    @IBOutlet weak var DateTo: UIDatePicker!
    @IBOutlet weak var DateFrom: UIDatePicker!
    
    @IBOutlet weak var charts1: PieChartView!
    @IBOutlet weak var chartview2: LineChartView!
    var depositAmount = 0.0
    @IBOutlet weak var chart3: BarChartView!
    var withdrawAmount = 0.0
    var sendAmount = 0.0
    
    @IBOutlet weak var chartView1: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        let today = Date()
        let lastMonth = Calendar.current.date(byAdding: .month, value: -1, to: today)!
        DateTo.date = today
        DateFrom.date = lastMonth
        DispatchQueue.main.async { [self] in
            configuration()
        }
        chartViews3.layer.shadowColor = UIColor.black.cgColor
        chartViews3.layer.shadowOpacity = 1
        chartViews3.layer.shadowOffset = CGSize(width: 0, height: 3)
        
        chartView2.layer.shadowColor = UIColor.black.cgColor
        chartView2.layer.shadowOpacity = 1
        chartView2.layer.shadowOffset = CGSize(width: 0, height: 3)
        
        
        chart1View.layer.shadowColor = UIColor.black.cgColor
        chart1View.layer.shadowOpacity = 1
        chart1View.layer.shadowOffset = CGSize(width: 0, height: 3)
    }
    // MARK: - Navigation
    func configuration(){
        
       var transactionModel = BarchartTransaction()
        transactionModel.Transaction { [self] transactions in
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            DispatchQueue.main.async { [self] in
                
                let sortedTransaction = transactions.alltransaction.filter{ transaction in let transactionDate = dateFormatter.date(from:transaction.TransactionDate)!
                    
                    return transactionDate >= DateFrom.date && transactionDate <= DateTo.date}.sorted{$0.TransactionDate < $1.TransactionDate}
                var depositEntries: [ChartDataEntry] = []
                var withdrawEntries: [ChartDataEntry] = []
                var sendEntries: [ChartDataEntry] = []
                var dataEntries: [BarChartDataEntry] = []
                var xValues: [String] = []
                var currentDate = ""
                var currentDeposit = 0.0
                var currentWithdraw = 0.0
                var currentSend = 0.0
                var currentTotalAmount = 0.0
                for transaction in sortedTransaction {
                    if transaction.TransactionDate != currentDate {
                        //linechert
                        depositEntries.append(ChartDataEntry(x: Double(depositEntries.count), y: currentDeposit))
                        withdrawEntries.append(ChartDataEntry(x: Double(withdrawEntries.count), y: currentWithdraw))
                        sendEntries.append(ChartDataEntry(x: Double(sendEntries.count), y: currentSend))
                        
                        
                        //barChart
                        dataEntries.append(BarChartDataEntry(x: Double(dataEntries.count), yValues: [currentDeposit, currentWithdraw, currentSend]))
                        xValues.append(transaction.TransactionDate)
                        currentDeposit = 0.0
                        currentWithdraw = 0.0
                        currentSend = 0.0
                        currentDate = transaction.TransactionDate
                    }
                    for transaction in transactions.alltransaction {
                        switch transaction.TransactionType {
                        case "deposit":
                            self.depositAmount += Double(transaction.amount) ?? 0.0
                            print(depositAmount)
                        case "withdraw":
                            withdrawAmount += Double(transaction.amount) ?? 0.0
                            print(withdrawAmount)
                        case "send":
                            sendAmount += Double(transaction.amount) ?? 0.0
                            print(sendAmount)
                        default:
                            break
                        }
                    }
                    switch transaction.TransactionType {
                    case "deposit":
                        currentDeposit += Double(transaction.amount) ?? 0.0
                    case "withdraw":
                        currentWithdraw += Double(transaction.amount) ?? 0.0
                    case "send":
                        currentSend += Double(transaction.amount) ?? 0.0
                    default:
                        break
                    }
                }
                DispatchQueue.main.async { [self] in
                    let formatter = NumberFormatter()
                    formatter.numberStyle = .currency
                    formatter.currencySymbol = "Ksh"
                    let entries: [PieChartDataEntry] = [
                        PieChartDataEntry(value: depositAmount,label: "deposit"),
                        PieChartDataEntry(value: withdrawAmount,label: "withdraw"),
                        PieChartDataEntry(value: sendAmount,label: "send")]
                    let dataSet = PieChartDataSet(entries: entries)
                    dataSet.colors = [UIColor.green, UIColor.red, UIColor.blue]
                    dataSet.valueTextColor = .black // Set the text color to black
                    dataSet.valueFont = UIFont.systemFont(ofSize: 12) // Set the font size
                    let data = PieChartData(dataSet: dataSet)
                    data.setValueFormatter(DefaultValueFormatter(formatter: formatter))
                    //formatter.numberStyle = .decimal
                    data.setValueFormatter(DefaultValueFormatter(formatter: formatter))
                    charts1.data = data
                    charts1.legend.enabled = true
                    charts1.chartDescription.text = "Total transactions of 2023"
                    //charts1.chartDescription.position = CGPoint(x: charts1.center.x, y: 10)
                    charts1.chartDescription.position = CGPoint(x: charts1.bounds.width - 10, y: 10)
                    charts1.chartDescription.textAlign = .right
                    charts1.notifyDataSetChanged()
                }
                DispatchQueue.main.async { [self] in
                    depositEntries.append(ChartDataEntry(x: Double(depositEntries.count), y: currentDeposit))
                    withdrawEntries.append(ChartDataEntry(x: Double(withdrawEntries.count), y: currentWithdraw))
                    sendEntries.append(ChartDataEntry(x: Double(sendEntries.count), y: currentSend))
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat = "yyyy-MM-dd"
                    let dates = xValues.map { dateFormatter.date(from: $0) }.compactMap { $0 }
                    let xValuesFormatted = dates.map { dateFormatter.string(from: $0)}
                    let currencyFormatter = NumberFormatter()
                    currencyFormatter.numberStyle = .currency
                    currencyFormatter.currencySymbol = "Ksh"
                    currencyFormatter.maximumFractionDigits = 2
                    let depositDataSet = LineChartDataSet(entries: depositEntries, label: "Deposit")
                    depositDataSet.colors = [.systemGreen]
                    depositDataSet.drawCirclesEnabled = false
                    let withdrawDataSet = LineChartDataSet(entries: withdrawEntries, label: "Withdraw")
                    withdrawDataSet.colors = [.systemRed]
                    withdrawDataSet.drawCirclesEnabled = false
                    
                    let sendDataSet = LineChartDataSet(entries: sendEntries, label: "Send")
                    sendDataSet.colors = [.systemBlue]
                    sendDataSet.drawCirclesEnabled = false
                    let data = LineChartData(dataSets: [depositDataSet, withdrawDataSet, sendDataSet])
                    chartview2.data = data
                    let leftAxisFormatter = DefaultAxisValueFormatter(formatter: currencyFormatter)
                    chartview2.leftAxis.valueFormatter = leftAxisFormatter
                    chartview2.chartDescription.text = "Transactions by date in 2023"
                    chartview2.chartDescription.position = CGPoint(x: charts1.bounds.width - 10, y: 10)
                    chartview2.chartDescription.textAlign = .right
                    chartview2.xAxis.valueFormatter = IndexAxisValueFormatter(values: xValues)
                    chartview2.xAxis.labelPosition = .bottom
                    chartview2.xAxis.drawLabelsEnabled = true
                    chartview2.xAxis.drawGridLinesEnabled = false
                    chartview2.xAxis.granularityEnabled = true
                    chartview2.xAxis.granularity = 1.0
                    chartview2.xAxis.labelRotationAngle = -45
                    chartview2.legend.enabled = true
                    chartview2.rightAxis.enabled = false
                    chartview2.leftAxis.drawGridLinesEnabled = false
                    chartview2.leftAxis.axisMinimum = 0.0
                    chartview2.notifyDataSetChanged()
                }
                DispatchQueue.main.async { [self] in
                    if currentTotalAmount != 0.0 {
                        dataEntries.append(BarChartDataEntry(x: Double(dataEntries.count), y: currentTotalAmount))
                        xValues.append(currentDate)
                    }
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat = "yyyy-MM-dd"
                    let dates = xValues.map { dateFormatter.date(from: $0)! }
                    let xValuesFormatted = dates.map { dateFormatter.string(from: $0) }
                    let currencyFormatter = NumberFormatter()
                    currencyFormatter.numberStyle = .currency
                    currencyFormatter.currencySymbol = "Ksh"
                    currencyFormatter.maximumFractionDigits = 2
                    let dataSet = BarChartDataSet(entries: dataEntries, label: "Transaction Amount")
                    dataSet.colors = [UIColor.blue, UIColor.red, UIColor.green]
                    dataSet.stackLabels = ["Send", "Withdraw", "Deposit"]
                    
                    let data = BarChartData(dataSet: dataSet)
                    chart3.data = data
                    let leftAxisFormatter = DefaultAxisValueFormatter(formatter: currencyFormatter)
                    chart3.leftAxis.valueFormatter = leftAxisFormatter
                    chart3.chartDescription.text = "Transactions by Date in 2023"
                    chart3.chartDescription.position =  CGPoint(x: 10, y: chart3.center.y)
                    chart3.chartDescription.textAlign = .right
                    chart3.xAxis.valueFormatter = IndexAxisValueFormatter(values: xValuesFormatted)
                    chart3.notifyDataSetChanged()
                    
                    // Configure the x-axis
                    chart3.xAxis.labelPosition = .bottom
                    chart3.xAxis.drawGridLinesEnabled = false
                    chart3.xAxis.granularityEnabled = true
                    chart3.xAxis.granularity = 1.0
                    chart3.xAxis.labelRotationAngle = -45
                    
                    // Configure the y-axis
                    chart3.rightAxis.enabled = false
                    chart3.leftAxis.drawGridLinesEnabled = false
                    chart3.leftAxis.axisMinimum = 0.0
                    
                    // Configure the legend
                    chart3.legend.verticalAlignment = .top
                    chart3.legend.horizontalAlignment = .center
                }
                
            }
            
        }
        //
    }

}

