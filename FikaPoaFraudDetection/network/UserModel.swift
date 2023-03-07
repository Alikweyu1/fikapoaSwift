//
//  UserModel.swift
//  FikaPoaFraudDetection
//
//  Created by SOFTWARE on 14/03/2023.
//

import Foundation
class User{
    var userid :Int?
    var firstname : String?
    var middlename : String?
    var lastname: String?
    var gender:String?
    var dob:String?
    var permanentAddress:String?
    var currentAddress :String?
    var picode:String?
    var occupation:String?
    var state:String?
    var areaofResident:String?
    var city:String?
    var country:String?
    var phone:String?
    var email:String?
    var deviceName :String?
    var deviceId :String?
    var otp:String?
    
    
    
}
class UserModel {
    static let shared = UserModel()
    private init() {}
    
    var currentUser: User?
}
