//
//  SendViewController.swift
//  FikaPoaFraudDetection
//
//  Created by SOFTWARE on 17/03/2023.
//

import UIKit
import Alamofire
import Reachability
import MBProgressHUD
class SendViewController: UIViewController, UITextFieldDelegate{
    let lineColor = UIColor(red: 0.9098, green: 0.1961, blue: 0.9608, alpha: 1.0)
    var reachability = try! Reachability()
    var loadingindicator =  MBProgressHUD ()
    let reachabilityManager = Alamofire.NetworkReachabilityManager(host: "www.apple.com")
    let countryCode = "254"
    @IBOutlet weak var phoneView: UIView!
    @IBOutlet weak var phoneNumber: UITextField!
    @IBOutlet weak var sendBt: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        Designing()
        phoneNumber.delegate = self
        sendBt.isEnabled = false
        // Do any additional setup after loading the view.
    }
    

    @IBAction func sendBtTapped(_ sender: Any) {
        do{
            self.reachability = try Reachability.init()
        }
        catch{
            print("fail to start reachability")
        }
        if((reachability.connection) != .unavailable){
            
            let phoneNumberFrom = UserDefaults.standard.string(forKey: "phone")
            sendingMoney()
            
        }else{
            let alart = UIAlertController(title: "", message: "No internet Connection", preferredStyle: .alert)
            
            let closeBtn = UIAlertAction(title: "CLose", style: UIAlertAction.Style.cancel,handler: {action in
                print("Close")
            })
            alart.addAction(closeBtn)
            self.present(alart, animated: true,completion: nil)
        
        }
    }
    

    @IBAction func cancelBtnTapped(_ sender: Any) {
        dismiss(animated: true)
    }
    func Designing(){
        phoneView.layer.cornerRadius = 30
        phoneView.layer.masksToBounds = true
        self.phoneNumber.addBottomBorderLinewithColor(Color: .white, width: 3)
        phoneNumber.delegate = self
    }
    
    func sendingMoney(){
        do{
            self.reachability = try Reachability.init()
        } catch{
            print("Fail to start notifier")
        }
        if ((reachability.connection) != .unavailable){
            
            guard let url = URL(string: "http://localhost:3001/payment") else{return}
            let dataPayment = parameters()
            var request = URLRequest(url: url)
            do{
                request.httpMethod = "POST"
                request.setValue("Application/Json", forHTTPHeaderField: "Content-Type")
                request.httpBody = try? JSONSerialization.data(withJSONObject: dataPayment,options: [])
                URLSession.shared.dataTask(with: request) { (data, response,error) in
                    if let error = error{
                        print("chack error on \(error.localizedDescription)")
                    }else{
                       
                        
                            //decode response from database
                            let jsonDecode = try? JSONSerialization.jsonObject(with: data!,options: [])
                            if let dataApi = jsonDecode as? [String:Any],
                               let dataString = dataApi["data"] as? [String:Any]{
                                print(dataString)
                                self.phoneNumber.text = ""
                            }
                        
                    }
                                                 
                } .resume()
            }
        }else{
            print("Not connecting to the network")
        }
            
    }
    @IBAction func textChanged(_ sender: Any) {
        checkValidation()
    }
   func checkValidation() {
        let phoneNumber = phoneNumber.text ?? ""
        let numericSet = CharacterSet.decimalDigits
        let isNumeric = phoneNumber.rangeOfCharacter(from: numericSet.inverted) == nil

        if phoneNumber.isEmpty || phoneNumber.count < 10 || phoneNumber.count > 12 || !isNumeric{
            sendBt.isEnabled = false
        }else if (phoneNumber.count < 0) {
            sendBt.isEnabled = false
        }else {
            sendBt.isEnabled = true
        }

    }
    func parameters() -> [String:Any]{
        var sendPhonenumbersToApi = [String:Any]()
        var partyBPhoneNumber = phoneNumber.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        let phoneNumberFrom = UserDefaults.standard.string(forKey: "phone")
        
        if partyBPhoneNumber.hasPrefix("+254") {
            partyBPhoneNumber = "254" + String(partyBPhoneNumber.dropFirst(4))
        } else if partyBPhoneNumber.hasPrefix("254") {
            partyBPhoneNumber = "254" + String(partyBPhoneNumber.dropFirst(3))
        } else if partyBPhoneNumber.hasPrefix("0") {
            partyBPhoneNumber = "254" + String(partyBPhoneNumber.dropFirst())
        }
        sendPhonenumbersToApi["PartyB"] = partyBPhoneNumber
        sendPhonenumbersToApi["PartyA"] = phoneNumberFrom
        return sendPhonenumbersToApi
    }
  
}
