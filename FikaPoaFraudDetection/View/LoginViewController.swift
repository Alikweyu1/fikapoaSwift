//
//  LoginViewController.swift
//  FikaPoaFraudDetection
//
//  Created by SOFTWARE on 02/03/2023.
//

import UIKit
import Alamofire
import Reachability
import IQKeyboardManagerSwift
import MBProgressHUD
@available(iOS 13.0, *)
class LoginViewController: UIViewController,UITextFieldDelegate {
    @IBOutlet weak var phone_no: UITextField!
    
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var password: UITextField!
    let lineColor = UIColor(red: 0.9098, green: 0.1961, blue: 0.9608, alpha: 1.0)
    var reachability:Reachability!
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Login"
        self.phone_no.addBottomBorderLinewithColor(Color: lineColor, width: 1)
        self.password.addBottomBorderLinewithColor(Color: lineColor, width: 1)
        
        checkField()
        phone_no.delegate = self
        
    }
    

    
    
    // MARK: - Navigation

    @IBAction func forgetPasswordTapped(_ sender: Any) {
       performSegue(withIdentifier: "forgetPassword", sender: self)
    }

    @IBAction func logiClicked(_ sender: Any) {
        loginAction(phone: phone_no.text!, password: password.text!)
        
    }
    @IBAction func testTapped(_ sender: Any) {
        print("test Tapped")
        performSegue(withIdentifier: "charts", sender: self)
    }
    func loginAction(phone:String,password:String){
        do{
            self.reachability = try Reachability.init()
        }catch{
            print("No notifier was started")
        }
        if((reachability.connection) != .unavailable){
            let transparentBlack = UIColor(red: 0, green: 0, blue: 0, alpha: 0)
            let loadingData = MBProgressHUD.showAdded(to: self.view, animated: true)
            loadingData.backgroundColor = transparentBlack
            loadingData.label.text = "Wait...."
            
           let sendParameters = creatingLoginParameters()
            guard let url = URL(string: "http://localhost:3001/login") else{return}
           var request = URLRequest(url: url)
            
            do{
                request.httpMethod = "POST"
                request.setValue("application/json", forHTTPHeaderField: "Content-Type")
                let requestId = UUID().uuidString
               // request.setValue(requestId, forHTTPHeaderField: "X-Request-ID")
              request.httpBody = try! JSONSerialization.data(withJSONObject: sendParameters,options: [])
                URLSession.shared.dataTask(with: request){ (data,response,error) in
                    if let error = error{
                        print("check error on: \(error.localizedDescription)")
                    }else{
                        if let data = data, let response = response as? HTTPURLResponse,response.statusCode == 200{
                            do{
                                
                                let json = try JSONSerialization.jsonObject(with: data,options: []) as? [String:Any]
                                if let responsMessage = json as? [String:Any], let messageString = responsMessage["message"] as? String{
                                    if let userData = responsMessage["data"] as? [String:Any]{
                                        DispatchQueue.main.async {
                                            loadingData.hide(animated: true)
                                            let userDetails = User()
                                            userDetails.userid = userData["u_id"] as? Int
                                            userDetails.firstname = userData["firstName"] as? String
                                            userDetails.middlename = userData["middleName"] as? String
                                            userDetails.lastname = userData["lastName"] as? String
                                            userDetails.gender = userData["gender"] as? String
                                            userDetails.dob = userData["dateOfBirth"] as? String
                                            userDetails.occupation = userData["occupation"] as? String
                                            userDetails.permanentAddress = userData["permanentAddress"] as? String
                                            userDetails.currentAddress = userData["currentAddress"] as? String
                                            userDetails.phone = userData["mobileNumber"] as? String
                                            userDetails.email = userData["email"] as? String
                                            userDetails.picode = userData["pinCode"] as? String
                                            userDetails.areaofResident = userData["areaofResident"] as? String
                                            userDetails.city = userData["city"] as? String
                                            userDetails.state = userData["state"] as? String
                                            userDetails.country = userData["country"] as? String
                                            userDetails.deviceName = UIDevice.current.name
                                            userDetails.deviceId = UIDevice.current.identifierForVendor?.uuidString ?? ""
                                            UserModel.shared.currentUser = userDetails
                                            let details = UserModel.shared.currentUser
                                            UserDefaults.standard.set(details?.userid, forKey: "user_id")
                                            UserDefaults.standard.set(details?.firstname, forKey: "firstname")
                                            UserDefaults.standard.set(details?.middlename, forKey: "middlename")
                                            UserDefaults.standard.set(details?.lastname, forKey: "lastname")
                                            UserDefaults.standard.set(details?.gender, forKey: "gender")
                                            UserDefaults.standard.set(details?.dob, forKey: "dob")
                                            UserDefaults.standard.set(details?.occupation, forKey: "occupation")
                                            UserDefaults.standard.set(details?.permanentAddress, forKey: "permanentAddress")
                                            UserDefaults.standard.set(details?.currentAddress, forKey: "currentAddress")
                                            UserDefaults.standard.set(details?.phone, forKey: "phone")
                                            UserDefaults.standard.set(details?.email, forKey: "useremail")
                                            UserDefaults.standard.set(details?.picode, forKey: "picode")
                                            UserDefaults.standard.set(details?.areaofResident, forKey: "areaofResident")
                                            UserDefaults.standard.set(details?.city, forKey: "city")
                                            UserDefaults.standard.set(details?.state, forKey: "state")
                                            UserDefaults.standard.set(details?.country, forKey: "country")
                                            UserDefaults.standard.set(details?.deviceName, forKey: "deviceName")
                                            UserDefaults.standard.set(details?.deviceId, forKey: "deviceId")
                                            print(userData)
                                            
                                        }
                                       
                                    }else{
                                        print("fail to serialize user  data")
                                    }
                                    DispatchQueue.main.async {
                                        let alert = UIAlertController(title: "", message: messageString, preferredStyle: .alert)
                                        let closeBtn = UIAlertAction(title: "CLose", style: UIAlertAction.Style.cancel,handler: { action in
                                            self.phone_no.text = ""
                                            self.password.text = ""
                                            self.performSegue(withIdentifier: "home2", sender: self)
                                            /*DispatchQueue.main.async {
                                                let mainview = self.storyboard?.instantiateViewController(withIdentifier:"LipaViewController" ) as! LipaViewController
                                                mainview.modalPresentationStyle = .currentContext
                                                mainview.modalTransitionStyle = .flipHorizontal
                                                self.present(mainview, animated: true,completion: nil)
                                            }*/
                                        })
                                        alert.addAction(closeBtn)
                                        self.present(alert, animated: true, completion: nil)
                                    }
                                }
                                
                                
                                
                            }
                            catch{
                                print("erron on decoding data")
                            }
                        } else if let data = data, let response = response as? HTTPURLResponse,response.statusCode == 401{
                            do{
                                
                                
                                let json = try JSONSerialization.jsonObject(with: data,options: []) as? [String:Any]
                                if let responsMessage = json as? [String:Any], let messageString = responsMessage["message"] as? String{
                                    DispatchQueue.main.async {
                                        loadingData.hide(animated: true)
                                        let alert = UIAlertController(title: "", message: messageString, preferredStyle: .alert)
                                        let Close = UIAlertAction(title: "Close", style: UIAlertAction.Style.cancel,handler: { action in
                                            
                                        })
                                        alert.addAction(Close)
                                        self.present(alert, animated: true, completion: nil)
                                    }
                                    
                                }
                            } catch{
                                print("fail to decode unauthentication message")
                            }
                        }
                    }
                }.resume()
                
               /* _ = try! JSONSerialization.data(withJSONObject: sendParameters)
                //performSegue(withIdentifier: "home", sender: self)
                let url:String = "http://localhost:3001/Login"
                AF.request(url, method: .post, parameters: sendParameters).responseData{ response in
                    switch response.result{
                    case .success(let data):
                        do{
                            loadingData.hide(animated: true)
                            let json = try! JSONSerialization.jsonObject(with: data,options: [])
                            
                            if let responsMessage = json as? [String:Any],
                               let responseString = responsMessage["message"] as? String{
                                print(responseString)
                               // print(sendParameters)
                                if let userData = responsMessage["data"] as? [String:Any] {
                                           print(userData)
                                    let userDetails = User()
                                    userDetails.userid = userData["u_id"] as? Int
                                    userDetails.firstname = userData["firstName"] as? String
                                    userDetails.middlename = userData["middleName"] as? String
                                    userDetails.lastname = userData["lastName"] as? String
                                    userDetails.gender = userData["gender"] as? String
                                    userDetails.dob = userData["dateOfBirth"] as? String
                                    userDetails.occupation = userData["occupation"] as? String
                                    userDetails.permanentAddress = userData["permanentAddress"] as? String
                                    userDetails.currentAddress = userData["currentAddress"] as? String
                                    userDetails.phone = userData["mobileNumber"] as? String
                                    userDetails.email = userData["email"] as? String
                                    userDetails.picode = userData["pinCode"] as? String
                                    userDetails.areaofResident = userData["areaofResident"] as? String
                                    userDetails.city = userData["city"] as? String
                                    userDetails.state = userData["state"] as? String
                                    userDetails.country = userData["country"] as? String
                                    userDetails.deviceName = UIDevice.current.name
                                    userDetails.deviceId = UIDevice.current.identifierForVendor?.uuidString ?? ""
                                    
                                    UserModel.shared.currentUser = userDetails
                                    let details = UserModel.shared.currentUser
                                    UserDefaults.standard.set(details?.userid, forKey: "user_id")
                                    UserDefaults.standard.set(details?.firstname, forKey: "firstname")
                                    UserDefaults.standard.set(details?.middlename, forKey: "middlename")
                                    UserDefaults.standard.set(details?.lastname, forKey: "lastname")
                                    UserDefaults.standard.set(details?.gender, forKey: "gender")
                                    UserDefaults.standard.set(details?.dob, forKey: "dob")
                                    UserDefaults.standard.set(details?.occupation, forKey: "occupation")
                                    UserDefaults.standard.set(details?.permanentAddress, forKey: "permanentAddress")
                                    UserDefaults.standard.set(details?.currentAddress, forKey: "currentAddress")
                                    UserDefaults.standard.set(details?.phone, forKey: "phone")
                                    UserDefaults.standard.set(details?.email, forKey: "useremail")
                                    UserDefaults.standard.set(details?.picode, forKey: "picode")
                                    UserDefaults.standard.set(details?.areaofResident, forKey: "areaofResident")
                                    UserDefaults.standard.set(details?.city, forKey: "city")
                                    UserDefaults.standard.set(details?.state, forKey: "state")
                                    UserDefaults.standard.set(details?.country, forKey: "country")
                                    UserDefaults.standard.set(details?.deviceName, forKey: "deviceName")
                                    UserDefaults.standard.set(details?.deviceId, forKey: "deviceId")
                                    
                                    
                                }else{
                                    print("fail to serialize user  data")
                                }
                                let alert = UIAlertController(title: "", message: responseString, preferredStyle: .alert)
                                let close = UIAlertAction(title: "Close", style: .cancel, handler: { action in
                                    self.phone_no.text = ""
                                    self.password.text = ""
                                    self.performSegue(withIdentifier: "home2", sender: self)
                                    
                                })
                                alert.addAction(close)
                                self.present(alert, animated: true, completion: nil)
                            }
                            else{
                                print("fail to Serialise Data")
                            }
                        }
                    case.failure(let error):
                        print("fail check database connection\(error)")
                    }
                }*/
            }
            
            
        }else{
            let alert = UIAlertController(title: "Network Error", message: "Check your internet connection", preferredStyle: .alert)
            let closeAlart = UIAlertAction(title: "close", style: .cancel,handler: { action in
                
            })
            alert.addAction(closeAlart)
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    //try
    
    func creatingLoginParameters()-> [String:Any]{
        var sendDataToApi = [String:Any]()
        let phoneCode = "254"
        //sendDataToApi["deviceId"] = UIDevice.current.identifierForVendor?.uuidString ?? ""
        //UserDefaults.standard.set(sendDataToApi["deviceId"], forKey: "deviceIdKey") // Store device ID in UserDefaults
        //sendDataToApi["DeviceName"] = UIDevice.current.name
        sendDataToApi["mobileNumber"] = phoneCode + phone_no.text!.trimmingCharacters(in: .whitespacesAndNewlines).replacingOccurrences(of: "^0+", with: "", options: .regularExpression)
        sendDataToApi["password"] = password.text!.trimmingCharacters(in: .newlines)
        
        
        return sendDataToApi
        
    }
    
    @IBAction func testingBtn(_ sender: Any) {
      /*if  let open = storyboard?.instantiateViewController(withIdentifier: "LipaViewController" ) as? LipaViewController{
            navigationController?.pushViewController(open, animated: true)
        }
       */
        performSegue(withIdentifier: "testing", sender: self)
    }
    func checkField(){
        if phone_no.text == ""  {
            loginBtn.isEnabled = false
    }else if password.text == ""{
        loginBtn.isEnabled = false
    }else{
        loginBtn.isEnabled = true
    }
        }
    
    @IBAction func textOnChanges(_ sender: Any) {
        checkField()
    }
   
    @IBAction func passwordOnChange(_ sender: Any) {
        checkField()
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
      
        
        return true
    }
    
    




}
