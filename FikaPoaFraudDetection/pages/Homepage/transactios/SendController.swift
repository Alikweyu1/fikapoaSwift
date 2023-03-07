//
//  SendController.swift
//  FikaPoaFraudDetection
//
//  Created by SOFTWARE on 22/03/2023.
//

import UIKit
import Reachability
import MBProgressHUD

class SendController: UIViewController ,UITextFieldDelegate{

    @IBOutlet weak var xbtn: UIButton!
    @IBOutlet weak var titlelbl: UILabel!
    @IBOutlet weak var ResendBtn: UIButton!
    @IBOutlet weak var closebtn: UIButton!
    @IBOutlet weak var sendBtn: UIButton!
    @IBOutlet weak var checkBtn: UIButton!
    @IBOutlet weak var amount: UITextField!
    @IBOutlet weak var phoneNumber: UITextField!
    @IBOutlet weak var sendTolbl: UILabel!
    @IBOutlet weak var successimage: UIImageView!
    let networkStatusView = NetworkView()
  var reachability = try? Reachability()
    let loadingHud = MBProgressHUD()
    var toName:String?
    var successful:String?
    override func viewDidLoad() {
        super.viewDidLoad()

        successimage.isHidden = true
        sendTolbl.text = "--------"
        
        amount.isHidden = true
        checkBtn.setTitle("Check phone number", for: .normal)
        phoneNumber.delegate = self
        amount.delegate = self
        checkBtn.isEnabled = false
        sendBtn.isHidden = true
        closebtn.isHidden = true
        ResendBtn.isHidden = true
        
        checkField()
    }
     


    // MARK: - Navigation

    @IBAction func fieldCheck(_ sender: Any) {
        checkField()
    }
    @IBAction func closeBtn(_ sender: Any) {
        self.dismiss(animated: true)
    }
    @IBAction func checkBtnTaped(_ sender: Any) {
        phoneNumber.isEnabled = false
        do{
            self.reachability = try Reachability.init()
        }catch{
            print("fail to start notifier")
        }
        if ((reachability?.connection) != .unavailable){
          var loading = MBProgressHUD.showAdded(to: self.view, animated: true)
            let transparentColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0)
            loading.label.text = "checking...."
            loading.backgroundColor = transparentColor
            let datas = createParameters()
            guard let url = URL(string: "http://localhost:3001/checkingPhonePayment") else{return}
            var request = URLRequest(url: url)
            
            do{
                
                request.httpMethod = "POST"
                request.setValue("Application/Json", forHTTPHeaderField: "Content-Type")
                request.httpBody = try! JSONSerialization.data(withJSONObject: datas,options: [])
                URLSession.shared.dataTask(with: request){ (data,response,error) in
                    if let error = error{
                        print("check this \(error.localizedDescription)")
                        DispatchQueue.main.async {
                            loading.hide(animated: true)
                        }
                        
                    }else{
                        
                        if let data = data, let response = response as? HTTPURLResponse,response.statusCode == 200{
                            do{
                                let json = try JSONSerialization.jsonObject(with: data,options: []) as? [String:Any]
                                self.toName = json!["toName"] as? String
                                //print(self.toName!)
                                
                                DispatchQueue.main.async {
                                    self.sendTolbl.text = "To:" + "" + self.toName!
                                    self.checkBtn.isHidden = true
                                    self.phoneNumber.isHidden = true
                                    self.amount.isHidden = false
                                    self.sendBtn .isHidden = false
                                    self.sendBtn.isEnabled = false
                                    loading.hide(animated: true)
                                    self.closebtn.isHidden = true
                                    self.ResendBtn.isHidden = true
                                    self.titlelbl.isHidden = true
                                    
                                    
                                }
                                
                                
                            }catch{
                                
                            }
                        }
                    }
                } .resume()
                //loading.hide(animated: true)
            }
        }else{
            let alert = UIAlertController(title: "", message: "No network connection", preferredStyle: .alert)
            let closeBtn = UIAlertAction(title: "Close", style: UIAlertAction.Style.cancel,handler: { action in
                
            })
            alert.addAction(closeBtn)
            self.present(alert, animated: true,completion: nil)
        }
    }
    
    @IBAction func sendMoneyBtn(_ sender: Any) {
        amount.isEnabled = false
        
        do{
            self.reachability = try Reachability.init()
        }catch{
            print("fail to start notifier")
        }
        if ((reachability?.connection) != .unavailable){
            do{
                var loading = MBProgressHUD.showAdded(to: self.view, animated: true)
                  let transparentColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0)
                  loading.label.text = "Please wait...."
                  loading.backgroundColor = transparentColor
                let dataMoney = sendMoney()
                guard let sendUrl = URL(string: "http://localhost:3001/SendMoney") else{return}
                var request = URLRequest(url: sendUrl)
                do{
                    checkNetworkStatus()
                    request.httpMethod = "POST"
                    request.setValue("Application/json", forHTTPHeaderField: "Content-Type")
                    request.httpBody = try! JSONSerialization.data(withJSONObject: dataMoney,options: [])
                    URLSession.shared.dataTask(with: request){ (data,response,error) in
                        if let error = error{
                            print("there is an error at:\(error.localizedDescription)")
                            DispatchQueue.main.async {
                                loading.hide(animated: true, afterDelay: 2)
                                
                            }
                        }else{
                            if let data = data, let response = response as? HTTPURLResponse,response.statusCode == 200{
                                do{
                                    let json = try JSONSerialization.jsonObject(with: data,options: []) as? [String:Any]
                                    self.successful = json!["success"] as? String
                                    //print(self.toName!)
                                    
                                    DispatchQueue.main.async {
                                        DispatchQueue.main.async {
                                            self.sendTolbl.text = self.successful! + " " + "sent" + " " + "to:" + " " + self.toName!
                                            self.successimage.isHidden = false
                                            self.amount.isHidden = true
                                            self.sendBtn.isHidden = true
                                            loading.hide(animated: true)
                                            self.titlelbl.isHidden = true
                                            self.closebtn.isHidden = false
                                            self.ResendBtn.isHidden = false
                                            self.xbtn.isHidden = true
                                        
                                        }
                                    }
                                    
                                    
                                }catch{
                                    
                                }
                            }
                        
                        }
                    }.resume()
                }
            }
        }else{
            let alert = UIAlertController(title: "", message: "No internet", preferredStyle: .alert)
            let closebtn = UIAlertAction(title: "Close", style: UIAlertAction.Style.cancel,handler: { action in
                
            })
            alert.addAction(closebtn)
            self.present(alert, animated: true)
        }
        
        
    }
    func checkField(){
      if  phoneNumber.text!.count >= 10 {
          checkBtn.isEnabled = true
      } else{
          checkBtn.isEnabled = false
      }
    }
    
    @IBAction func closeBtnTapped(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    @IBAction func ResendBtnTapped(_ sender: Any) {
       
        DispatchQueue.main.async {
            
            self.titlelbl.isHidden = false
            self.xbtn.isHidden = false
            self.successimage.isHidden = true
            self.amount.isHidden = true
            self.phoneNumber.isHidden = false
            self.sendBtn.isHidden = true
            self.closebtn.isHidden = true
            self.ResendBtn.isHidden = true
            self.checkBtn.isHidden = false
            self.sendTolbl.text = "------"
            self.phoneNumber.isEnabled = true
            self.phoneNumber.text = ""
            self.checkBtn .isEnabled = false
            self.amount.isEnabled = true
            self.amount.text = ""
        }
    }
    @IBAction func amountText(_ sender: Any) {
        checkAmount()
    }
    func checkAmount(){
        if amount.text!.trimmingCharacters(in: .whitespacesAndNewlines) != ""{
            sendBtn.isEnabled = true
        } else{
            sendBtn .isEnabled = false
        }
    }
    func createParameters() -> [String: Any] {
        var parameters = [String: Any]()
        parameters["money_to"] = phoneNumber.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        let phoneNumberFrom = UserDefaults.standard.string(forKey: "phone")
        parameters["money_from"] = phoneNumberFrom
        return parameters
    }
    func sendMoney() ->[String:Any]{
       var params = [String:Any]()
        params["To"] = phoneNumber.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        params["Amount"] = amount.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let phoneNumberFrom = UserDefaults.standard.string(forKey: "phone")
        params["From"] = phoneNumberFrom
      return params
    }
    func checkNetworkStatus() {
        let reachability = try? Reachability()
        if let connection = reachability?.connection {
            switch connection {
            case .wifi:
                networkStatusView.setProgress(1, animated: true)
                networkStatusView.showMessage("Connected to WiFi")
            case .cellular:
                networkStatusView.setProgress(1, animated: true)
                networkStatusView.showMessage("Connected to Cellular Data")
            case .unavailable:
                networkStatusView.setProgress(0, animated: true)
                networkStatusView.showMessage("No Network Connection")
            
            
            }
        } else {
            networkStatusView.setProgress(0, animated: true)
            
            
        }
    }
}
