//
//  TillModel.swift
//  FikaPoaFraudDetection
//
//  Created by SOFTWARE on 16/03/2023.
//

import Foundation
struct TillModel:Decodable{
    let PartA: String
    let description: String
    let transaction :[transaction]
}
struct transaction:Decodable{
    let id: String
    let amount: String
    let PartB:String
    let Timestamps:String

}
struct TillModels:Decodable{
    let Transaction:String
    //let phoneNumber:String
    let list:[TransactionMade]
}
struct TransactionMade: Decodable{
    let id :String
    let Timestamps:String
    let Amount:String
    let PartyA:String
    let PartyB:String
    let PhoneNumber:String
    let CallBackUR:String
    let CallBackUrl:String
    let AccountReference:String
    let ResponseCode:String
    let ResponseDescription:String
    let MerchantRequestID:String
    
}

/*
 "id": "1",
     "Timestamps": "2023-03-16 14:10:00",
     "Amount": "300",
     "PartyA": "254716198487",
     "PartyB": "254716191092",
     "PhoneNumber": "254716198487",
     "CallBackURL": "https:wwww.fikapoa.com/api/payment",
     "AccountReference": "nill",
     "ResponseCode": "001",
     "ResponseDescription": "The service request has been accepted successfully\r\n",
     "MerchantRequestID": "KQUYEEBD"
 */
