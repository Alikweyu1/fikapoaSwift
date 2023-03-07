//
//  ChartJson.swift
//  FikaPoaFraudDetection
//
//  Created by SOFTWARE on 24/03/2023.
//

import Foundation
import UIKit
import Reachability

struct BarchartTransaction{
    
   func Transaction (complition:@escaping(TransactionBarchart)->Void){
        guard let url = URL(string: "http://localhost:3001/transaction") else{return}
        URLSession.shared.dataTask(with: url){ (data,response,error) in
            if let error = error{
                print("check this error:-> \(error.localizedDescription)")
            }
            guard let JsonData = data else{return}
            let decoder = JSONDecoder()
            do{
                let decodeData = try! decoder.decode(TransactionBarchart.self, from: JsonData)
                complition(decodeData)
                //print("This is decided data->\(complition)")
            } catch{
                print("Fail to decode the data")
            }
        } .resume()
        
    }
}
