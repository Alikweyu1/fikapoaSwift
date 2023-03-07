//
//  CreanNewPasswordViewController.swift
//  FikaPoaFraudDetection
//
//  Created by SOFTWARE on 06/03/2023.
//

import UIKit
import Reachability
import MBProgressHUD
import SwiftUI
@available(iOS 13.0, *)
class CreanNewPasswordViewController: UIViewController,UITextFieldDelegate {
    var fname:String?
    var middlenames:String?
    var lastname:String?
    var dateofbith:String?
    var genders:String?
    var occupation:String?
    var permanent_address:String?
    var current_address:String?
    var email_address:String?
    var pincode:String?
    var country:String?
    var state:String?
    var city:String?
    var areaofResident:String?
    var phone_no:String?
    var passwordtext:String?
    
    
    @IBOutlet weak var imagelogo: UIImageView!
    
    @IBOutlet weak var passwordError: UILabel!
    @IBOutlet weak var errormessage: UILabel!
    @IBOutlet weak var createBtn: UIButton!
    @IBOutlet weak var confirmPassword: UITextField!
    @IBOutlet weak var password: UITextField!
    let lineColor = UIColor(red: 0.9098, green: 0.1961, blue: 0.9608, alpha: 1.0)
    var reachability = try! Reachability()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imagelogo.isHidden = true
        errormessage.isHidden = true
        createBtn.isEnabled = false
        passwordError .isHidden = true
        self.password.addBottomBorderLinewithColor(Color: lineColor, width: 1)
        self.confirmPassword.addBottomBorderLinewithColor(Color: lineColor, width: 1)
       
        password.delegate = self
        confirmPassword.delegate = self
    }
    

    // MARK: - Navigation

    @IBAction func createPasswordTapped(_ sender: Any) {
        do{
            self.reachability =  try Reachability.init()
        } catch{
            print("fail to start notifier")
        }
        if ((reachability.connection) != .unavailable){
            sendParams()
        } else{
            let alart = UIAlertController(title: "", message: "Check internet connection", preferredStyle: .alert)
            let closeBtn = UIAlertAction(title: "Close", style: UIAlertAction.Style.cancel,handler: { action in
                
            })
            alart .addAction(closeBtn)
            self.present(alart, animated: true,completion: nil)
        }
        
        
    }
    
    @IBAction func cancelBtnTapped(_ sender: Any) {
        //performSegue(withIdentifier: "home", sender: self)
    }
    
    @IBAction func fieldEdit(_ sender: Any) {
        checkField()
    }
    @IBAction func confirmpasswordBigin(_ sender: Any) {
        if confirmPassword.text! != password.text!{
            errormessage .isHidden = false
        }else{
            passwordError.isHidden = true
            errormessage .isHidden = true
        }
    }
    
    @IBAction func passwordEdidtEnd(_ sender: Any) {
        if ((password.text!.count) < 5 ){
            passwordError.isHidden = false
        } else{
            passwordError.isHidden = true
        }
    }
    func checkField(){
        if password.text!.isEmpty || confirmPassword.text!.isEmpty{
            createBtn.isEnabled = false
        }else if confirmPassword.text! != password.text! {
            createBtn.isEnabled = false
            errormessage .isHidden = false
        }else if ((password.text!.count) < 5 ){
            passwordError.isHidden = false
        }else{
            createBtn.isEnabled = true
            errormessage.isHidden = true
            passwordError.isHidden = true
        }
    }
    
    func createParameters() ->[String:Any]{
        var parameters = [String: Any]()
        parameters["firstName"] = fname!.trimmingCharacters(in: .whitespacesAndNewlines)
        parameters["middleName"] = middlenames!.trimmingCharacters(in: .whitespacesAndNewlines)
        parameters["lastName"] = lastname!.trimmingCharacters(in: .whitespacesAndNewlines)
        parameters["dateOfBirth"] = dateofbith
        parameters["gender"] = genders
        parameters["occupation"] = occupation
        parameters["permanentAddress"] = permanent_address!.trimmingCharacters(in: .whitespacesAndNewlines)
        parameters["currentAddress"] = current_address!.trimmingCharacters(in: .whitespacesAndNewlines)
        parameters["email"] = email_address!.trimmingCharacters(in: .whitespacesAndNewlines)
        parameters["pinCode"] = pincode!.trimmingCharacters(in: .whitespacesAndNewlines)
        parameters["country"] = country!.trimmingCharacters(in: .whitespacesAndNewlines)
        parameters["state"] = state!.trimmingCharacters(in: .whitespacesAndNewlines)
        parameters["city"] = city!.trimmingCharacters(in: .whitespacesAndNewlines)
        parameters["areaofResident"] = areaofResident!.trimmingCharacters(in: .whitespacesAndNewlines)
        parameters["password"] = password.text
        var phoneNumber = phone_no!.trimmingCharacters(in: .whitespacesAndNewlines)
        if phoneNumber.hasPrefix("+254") {
            phoneNumber = "254" + String(phoneNumber.dropFirst(4))
        } else if phoneNumber.hasPrefix("254") {
            phoneNumber = "254" + String(phoneNumber.dropFirst(3))
        } else if phoneNumber.hasPrefix("0") {
            phoneNumber = "254" + String(phoneNumber.dropFirst())
        }
        parameters["mobileNumber"] = phoneNumber
        return parameters
    }
    
   
    func sendParams(){
        let parameters = createParameters()
        guard let Url = URL(string: "http://localhost:3001/registration") else{return}
        var request = URLRequest(url: Url)
        do{
            request.httpMethod = "POST"
            request.setValue("Application/Json", forHTTPHeaderField: "Content-Type")
            request.httpBody = try? JSONSerialization.data(withJSONObject: parameters,options: [])
            
            URLSession.shared.dataTask(with: request){(data,response,error) in
                if let error = error{
                    print("check this error:\(error.localizedDescription)")
                }else{
                    DispatchQueue.main.async {
                        let alert = UIAlertController(title: "Congradulation!", message: "Welcome to Transaction Fraud Detection App\n  ", preferredStyle: .alert)
                        let Ok = UIAlertAction(title: "Restart App", style: UIAlertAction.Style.cancel,handler: { action in
                           exit(0)
                        })
                        alert.addAction(Ok)
                        self.present(alert, animated: true)
                    }
                    
                        
                   
                }
            } .resume()
        }
    }
}
