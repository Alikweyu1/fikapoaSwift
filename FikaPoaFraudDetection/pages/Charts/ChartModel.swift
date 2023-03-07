//
//  ChartModel.swift
//  FikaPoaFraudDetection
//
//  Created by SOFTWARE on 24/03/2023.
//

import Foundation
struct TransactionBarchart:Decodable{
let alltransaction:[alltransaction]
}
struct alltransaction: Decodable {
    let TransactionType: String
    let amount: String
    let TransactionDate: String
}
struct UserDetails:Decodable{
   let id:String
    let mobileNumber:String
    let gender:String
    let permanentAddress:String
    let pinCode:String
    let occupation:String
    let middleName:String
    let dateOfBirth:String
    let state:String
    let email:String
    let lastName:String
    let currentAddress:String
    let city:String
    let firstName:String
    let password:String
    let country:String
    let areaofResident:String
    
   /*/ {"id": "1","mobileNumber": "254716198487","gender": "Male", "permanentAddress": "900","pinCode": "3099", "occupation": "Swift Developer","middleName": "Kweyu", "dateOfBirth": "2005-03-23", "state": "Thika", "email": "alikweyu@gmail.com","lastName": "Makokha","currentAddress": "3093","city": "Thika", "firstName": "Ali", "password": "30996216", "country": "Kenya","areaofResident": "Thika"}*/
   
}

