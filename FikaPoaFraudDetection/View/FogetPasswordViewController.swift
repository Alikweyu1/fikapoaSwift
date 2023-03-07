//
//  FogetPasswordViewController.swift
//  FikaPoaFraudDetection
//
//  Created by SOFTWARE on 06/03/2023.
//

import UIKit
import MBProgressHUD

class FogetPasswordViewController: UIViewController {

    @IBOutlet weak var logo: UIImageView!
    @IBOutlet weak var phone_no: UITextField!
    let lineColor = UIColor(red: 0.9098, green: 0.1961, blue: 0.9608, alpha: 1.0)
    var otpResponse:String!
    override func viewDidLoad() {
        super.viewDidLoad()
        logo.isHidden = true
        self.phone_no.addBottomBorderLinewithColor(Color: lineColor, width: 1)
    }
    

    
    // MARK: - Navigation

     @IBAction func NextBtnTapped(_ sender: Any) {
         var phoneNumber = phone_no.text!.trimmingCharacters(in: .whitespacesAndNewlines)
         if phoneNumber.hasPrefix("+254") {
             phoneNumber = "254" + String(phoneNumber.dropFirst(4))
         } else if phoneNumber.hasPrefix("254") {
             phoneNumber = "254" + String(phoneNumber.dropFirst(3))
         } else if phoneNumber.hasPrefix("0") {
             phoneNumber = "254" + String(phoneNumber.dropFirst())
         }
         let ownerPhoneNumber = UserDefaults.standard.string(forKey: "phone")
         var transparentBlack = UIColor(red: 0, green: 0, blue: 0, alpha: 0)
         var loading = MBProgressHUD.showAdded(to: self.view, animated: true)
         loading.backgroundColor = transparentBlack
         loading.label.text = "Wait....."
         /*if phoneNumber != ownerPhoneNumber{
             let alert = UIAlertController(title: "", message: "Sorry we can not change the password of this number because it does not belong to you", preferredStyle: .alert)
             let close = UIAlertAction(title: "Close", style: UIAlertAction.Style.cancel,handler: { action in
                 loading.isHidden = true
             })
             alert.addAction(close)
             self.present(alert, animated: true)
             
         } else{*/
             let params = phonumberOtp()
             guard let url = URL(string: constant.API.UseDetailsURL) else{return}
             var request = URLRequest(url: url)
             do{
                 request.httpMethod = "POST"
                 request.setValue("applicationjson", forHTTPHeaderField: "Content-Type")
                 request.httpBody = try! JSONSerialization.data(withJSONObject: params,options: [])
                 URLSession.shared.dataTask(with: request){ data,respnse,error in
                     if let error = error{
                         print("check error at:->\(error.localizedDescription)")
                     }else{
                         if let data = data,let respnse = respnse as?HTTPURLResponse,respnse.statusCode == 200{
                            
                             do{
                                 let json = try JSONSerialization.jsonObject(with: data,options: []) as? [String:Any]
                                 if let statusString =  json as? [String:Any],let statusMessage = statusString["otp"] as? String{
                                     DispatchQueue.main.async {
                                         self.otpResponse = json?["otp"] as? String
                                         loading.hide(animated: true)
                                         
                                         print(self.otpResponse!)
                                     }
                                 }else{
                                     print("fail to decode the response")
                                 }
                             } catch{
                                 
                             }
                         }
                     }
                 }.resume()
             }
         //}
     }
    func phonumberOtp() ->[String:Any]{
        var sentphonumberOtp = [String:Any]()
        var phoneNumberOtp = phone_no.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        if phoneNumberOtp.hasPrefix("+254") {
            phoneNumberOtp = "254" + String(phoneNumberOtp.dropFirst(4))
        } else if phoneNumberOtp.hasPrefix("254") {
            phoneNumberOtp = "254" + String(phoneNumberOtp.dropFirst(3))
        } else if phoneNumberOtp.hasPrefix("0") {
            phoneNumberOtp = "254" + String(phoneNumberOtp.dropFirst())
        }
        sentphonumberOtp["MobileNumber"] = phoneNumberOtp
        return sentphonumberOtp
    }

}
