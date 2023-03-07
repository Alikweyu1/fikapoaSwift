//
//  TillTransactionJson.swift
//  FikaPoaFraudDetection
//
//  Created by SOFTWARE on 16/03/2023.
//

import UIKit
struct TillTransaction{
    func fetchTillTransactionList(completion: @escaping(TillModel)->Void){
        guard let url = URL(string: "http://localhost:3001/reactnative") else{return}
        URLSession.shared.dataTask(with: url){ data ,response,error in
            if let error = error{
                print("There is any error",error.localizedDescription)
            }
            guard let JsonData = data else{return}
            let decoder = JSONDecoder()
            do{
                let decodeData = try decoder.decode(TillModel.self, from: JsonData)
                completion(decodeData)
            }catch{
                print("This is the error",error.localizedDescription)
            }
            
        }.resume()
        
    }
    func fetchPayBillTransactionList(){
        
        
    }
}
//mpesa
struct MpesaTillTransaction{
    func fetchTillTransactionList(completion: @escaping(TillModels)->Void){
        guard let url = URL(string: "http://localhost:3001/mpesa") else{return}
        URLSession.shared.dataTask(with: url){ data ,response,error in
            if let error = error{
                print("There is any error",error.localizedDescription)
            }
            guard let JsonData = data else{return}
            let decoder = JSONDecoder()
            do{
                let decodeData = try decoder.decode(TillModels.self, from: JsonData)
                completion(decodeData)
            }catch{
                print("This is the error",error.localizedDescription)
            }
            
        }.resume()
        
    }
}



