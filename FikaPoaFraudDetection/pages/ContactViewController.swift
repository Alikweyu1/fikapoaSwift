//
//  ContactViewController.swift
//  FikaPoaFraudDetection
//
//  Created by SOFTWARE on 02/03/2023.
//

import UIKit
import Reachability
import MBProgressHUD
import Alamofire
class ContactViewController: UIViewController {

    @IBOutlet weak var permanet_address: UITextField!
    
    @IBOutlet weak var current_address: UITextField!
    
    @IBOutlet weak var emailaddress: UITextField!
    @IBOutlet weak var pincode: UITextField!
    
    @IBOutlet weak var country: UITextField!
    @IBOutlet weak var state: UITextField!
    @IBOutlet weak var city: UITextField!
    @IBOutlet weak var areaofResident: UITextField!
    @IBOutlet weak var phone_no: UITextField!
    
    @IBOutlet weak var lableTest: UILabel!
    @IBOutlet weak var submitButton: UIButton!
    
    let lineColor = UIColor(red: 0.9098, green: 0.1961, blue: 0.9608, alpha: 1.0)
    var fname:String?
    var middlenames:String?
    var lastname:String?
    var dateofbith:String?
    var genders:String?
    var occupation:String?
   
    
    var reachability = try! Reachability()
    var progressHUD: MBProgressHUD?
    let reachabilityManager = Alamofire.NetworkReachabilityManager(host: "www.apple.com")
    let countryCode = "254"
    override func viewDidLoad() {
        super.viewDidLoad()
        //progressNetwork()
       // NetworkViewController()
        country.isEnabled = false
        
        
        self.permanet_address.addBottomBorderLinewithColor(Color: lineColor, width: 2)
        self.current_address.addBottomBorderLinewithColor(Color: lineColor, width: 2)
       
        self.phone_no.addBottomBorderLinewithColor(Color: lineColor, width: 2)
       
        self.emailaddress.addBottomBorderLinewithColor(Color: lineColor, width: 2)
       
        self.pincode.addBottomBorderLinewithColor(Color: lineColor, width: 2)
       
        self.areaofResident.addBottomBorderLinewithColor(Color: lineColor, width: 2)
       
        self.city.addBottomBorderLinewithColor(Color: lineColor, width: 2)
       
        self.state.addBottomBorderLinewithColor(Color: lineColor, width: 2)
        self.country.addBottomBorderLinewithColor(Color: lineColor, width: 2)
       
       // checkContactField()
    }
    

    
    // MARK: - Navigation
    func checkContactField(){
        if permanet_address.text == "" || current_address.text == "" || phone_no.text == "" || emailaddress.text == "" || pincode.text == "" || areaofResident.text == "" || city.text == "" || state.text == "" || country.text == ""{
            submitButton.isEnabled = false
        }
        else{
            submitButton.isEnabled = true
        }
    }
    
    @IBAction func currentOnchange(_ sender: UITextField) {
        checkContactField()
        
    }
    
    @IBAction func textEnd(_ sender: Any) {
        checkContactField()
    }
    @IBAction func afterDatawasSent(_ sender: Any) {
        checkContactField()
    }
    @IBAction func textField(_ sender: UITextField) {
        checkContactField()
        print("text chenged")
    }
    
    @IBAction func submittingClicked(_ sender: Any) {
        registeringData(permanentAddress: permanet_address.text!, CurrentAddress: current_address.text!, mobile: phone_no.text! , emailAddress: emailaddress.text!, Pin: pincode.text!, City: city.text! ,State: state.text!, Country: country.text!)
        
    }
    
    func  registeringData(permanentAddress:String,CurrentAddress:String,mobile:String,emailAddress:String,Pin:String,City:String,State:String,Country:String){
        do{
            self.reachability = try Reachability.init()
            
        }catch{
            print("Fail to start Notifier")
        }
        if((reachability.connection) != .unavailable){
            //MBProgressHUD.showAdded(to: self.view, animated: true)
            let domains:String = "http://localhost/registration.php"
            let sendData = createParameters()
            let transparentBlack = UIColor(red: 0, green: 0, blue: 0, alpha: 0)
            let loadingindicator = MBProgressHUD.showAdded(to: self.view, animated: true)
            loadingindicator.backgroundColor = transparentBlack
            loadingindicator.label.text = "Wait....."
            print(sendData)
            do{
                _ = try! JSONSerialization.data(withJSONObject: sendData)
                
                AF.request(domains, method: .post, parameters: sendData).responseData{ response in
                    switch response.result{
                    case.success(let data):
                        do{
                            loadingindicator.hide(animated: true)
                            let json = try JSONSerialization.jsonObject(with: data,options: [])
                            if let responsMessage = json as? [String:Any],
                               let responseString = responsMessage["message"] as? String{
                                print("Data was sent\(responseString)")
                                let alert = UIAlertController(title: "", message: responseString, preferredStyle: .alert)
                                let close = UIAlertAction(title: "Close", style: .cancel, handler: { action in
                                    self.fname = ""
                                    self.middlenames = ""
                                    self.lastname = " "
                                    self.occupation = ""
                                    self.permanet_address.text = ""
                                    self.current_address.text = ""
                                    self.phone_no.text = ""
                                    self.emailaddress.text = ""
                                    self.pincode.text = ""
                                    self.areaofResident.text = ""
                                    self.city.text = ""
                                    self.state.text = ""
                                    self.country.text = ""
                                    self.navigationController?.popToRootViewController(animated: true)
                                })
                                alert.addAction(close)
                                self.present(alert, animated: true, completion: nil)
                            }else {
                                print("Failed to parse response data")
                                
                                let alert = UIAlertController(title: "Fail", message: "Phone number already exists", preferredStyle: .alert)
                                let close = UIAlertAction(title: "Close", style: .cancel, handler: { action in
                                    print("Close")
                                    
                                    
                                })
                                alert.addAction(close)
                                self.present(alert, animated: true, completion: nil)
                                
                            }
                        }catch{
                            
                        }
                    case.failure(let error):
                        print("No data was sent\(error)",error.localizedDescription)
                    }
                    
                }
            }
        }else{
            let alart = UIAlertController(title: "Fail", message: "Make sure you are connected to Internet", preferredStyle: .alert)
            
            let closeBtn = UIAlertAction(title: "CLose", style: UIAlertAction.Style.cancel,handler: {action in
                print("Close")
            })
            alart.addAction(closeBtn)
            self.present(alart, animated: true,completion: nil)
        }
        
        
    }
    func progressNetwork(){
        //mbprogress ----start------
        //self.progressBar.isHidden = true
        //progressBar .progress = 0.0
        let progressView = UIProgressView(progressViewStyle: .default)
        progressView.transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
        progressHUD = MBProgressHUD.showAdded(to: self.view, animated: true)
        progressHUD?.mode = .customView
        progressHUD?.customView = progressView
        progressHUD?.label.text = "Checking network connection"
        progressView.tintColor = UIColor.blue
        progressHUD?.progress = 0.5
        LoadData { progress in
                    self.progressHUD?.progress = progress
                }
        //mbprogress------Ends ------
    }
    func LoadData(updateProgress:@escaping (Float) -> Void){
        let totalProgressSteps = 10
        var currentProgress = 0
        let progressStep = 1.0 / Float(totalProgressSteps)

        // Simulate loading data by updating progress bar at regular intervals
        Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { timer in
            currentProgress += 1
            let progress = Float(currentProgress) * progressStep
            updateProgress(progress)

            // If progress reaches 100%, stop the timer
            if currentProgress == totalProgressSteps {
                timer.invalidate()
            }
        }
    }
    func createParameters() -> [String: Any] {
        var parameters = [String: Any]()
        
        parameters["fname"] = fname
        parameters["middlenames"] = middlenames
        parameters["lastname"] = lastname
        parameters["dateofbirth"] = dateofbith
        parameters["genders"] = genders
        parameters["occupation"] = occupation
        parameters["permanent_address"] = permanet_address.text
        parameters["current_address"] = current_address.text
        parameters["email_address"] = emailaddress.text
        parameters["pincode"] = pincode.text
        parameters["country"] = country.text
        parameters["state"] = state.text
        parameters["city"] = city.text
        parameters["areaofResident"] = areaofResident.text
        parameters["phone_no"] = countryCode + phone_no.text!
        
        return parameters
    }

    
}
extension UIView{
    func contactaddBottomBorderLinewithColor(Color:UIColor,width:CGFloat){
        let borderline = CALayer()
        borderline.backgroundColor = Color.cgColor
        borderline.frame = CGRect(x: 0, y: self.frame.size.height - width, width: self.frame.size.width, height: width)
        self.layer.addSublayer(borderline)
    }
}
