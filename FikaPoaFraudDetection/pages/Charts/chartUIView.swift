//
//  chartUIView.swift
//  FikaPoaFraudDetection
//
//  Created by SOFTWARE on 26/03/2023.
//
import Foundation
import SwiftUI
import Charts
struct savingModel:Identifiable{
    let id = UUID()
    let amount :Double
    let createdAt :Date
}
struct chartUIView: View {
    let list = [
        savingModel(amount: 200, createdAt: dateformatter.date(from:"15/03/2023") ?? Date()),
        savingModel(amount: 3000, createdAt: dateformatter.date(from:"16/03/2023") ?? Date()),
        savingModel(amount: 150, createdAt: dateformatter.date(from:"17/03/2023") ?? Date()),
        savingModel(amount: 4000, createdAt: dateformatter.date(from:"18/03/2023") ?? Date()),
        savingModel(amount: 500, createdAt: dateformatter.date(from:"19/03/2023") ?? Date()),
        savingModel(amount: 200, createdAt: dateformatter.date(from:"20/03/2023") ?? Date()),
        savingModel(amount: 150, createdAt: dateformatter.date(from:"21/03/2023") ?? Date()),
        savingModel(amount: 20, createdAt: dateformatter.date(from:"22/03/2023") ?? Date())
    ]
    func formatterDate(_ date:Date) -> String{
        let cul = Calendar.current
        let dateComponent = cul.dateComponents([.day,.month], from: date)
        
        return "-"
    }
                    static var dateformatter:DateFormatter = {
                        let df = DateFormatter()
                        df.dateFormat = "dd/mm/yyyy"
                        return df
                    }()
    @available(iOS 13.0, *)
    var body: some View {
        
        Text("")
    }
}


