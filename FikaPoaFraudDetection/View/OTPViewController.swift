//
//  OTPViewController.swift
//  FikaPoaFraudDetection
//
//  Created by SOFTWARE on 12/03/2023.
//

import UIKit
import Reachability
import MBProgressHUD

@available(iOS 13.0, *)
class OTPViewController: UIViewController,UITextFieldDelegate{
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
    var otpResponses:String?
    var getOtp:String?
    
    @IBOutlet weak var otp: UITextField!
    @IBOutlet weak var verifybtn: UIButton!
    @IBOutlet weak var errorbtn: UILabel!
    @IBOutlet weak var text4: UITextField!
    @IBOutlet weak var text3: UITextField!
    @IBOutlet weak var text2: UITextField!
    @IBOutlet weak var text1: UITextField!
   
    let lineColor = UIColor(red: 0.9098, green: 0.1961, blue: 0.9608, alpha: 1.0)
    var reachability = try! Reachability()
    override func viewDidLoad() {
        super.viewDidLoad()
        print(getOtp ?? "")
        //getOtp =  "3000"
        print("This is the rsponse:\(String(describing: getOtp))")
        checkValidation()
        clearBackground()
        text1.delegate = self
        text2.delegate = self
        text3.delegate = self
        text4.delegate = self
 otp.isHidden = true
        //otp.text = self.otpResponse
        // Do any additional setup after loading the view.
    }
    func clearBackground(){
        text1.backgroundColor = UIColor.clear
        text2.backgroundColor = UIColor.clear
        text3.backgroundColor = UIColor.clear
        text4.backgroundColor = UIColor.clear
        
        self.text1.addBottomBorderLinewithColor(Color: .black, width: 2)
        self.text2.addBottomBorderLinewithColor(Color: .black, width: 2)
        self.text3.addBottomBorderLinewithColor(Color: .black, width: 2)
        self.text4.addBottomBorderLinewithColor(Color: .black, width: 2)
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let toCreateView = segue.destination as? CreanNewPasswordViewController{
            toCreateView.fname = fname
            toCreateView.fname = fname
            toCreateView.middlenames = middlenames
            toCreateView.lastname = lastname
            toCreateView.occupation = occupation
            toCreateView.dateofbith = dateofbith
            toCreateView.genders = genders
            toCreateView.permanent_address = permanent_address
            toCreateView .current_address = current_address
            toCreateView.email_address = email_address
            toCreateView.pincode = pincode
            toCreateView.country = country
            toCreateView.state = state
            toCreateView.city = city
            toCreateView.areaofResident = areaofResident
            toCreateView.phone_no = phone_no
            
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if (textField.text!.count < 1) && (string.count > 0){
            if textField == text1{
                text2.becomeFirstResponder()
            }
            if textField == text2{
                text3.becomeFirstResponder()
            }
            if textField == text3{
                text4.becomeFirstResponder()
            }
            if textField == text4{
                text4.resignFirstResponder()
            }
            textField.text = string
            return false
        }else if ((textField.text!.count) >= 0) && (string.count == 0){
            if textField == text2{
                verifybtn .isEnabled = true
                text1.becomeFirstResponder()
            }
            if textField == text3{
                text2.becomeFirstResponder()
            }
            if textField == text4{
                text3.becomeFirstResponder()
            }
            if textField == text1{
                text1.resignFirstResponder()
            }
            textField.text = ""
            return false
        }else if((textField.text!.count) >= 1){
            textField.text = string
            return false
        }
        return true
    }
    
    @IBAction func resendBtnTapped(_ sender: Any) {

        
    }
    @IBAction func closeBtnTapped(_ sender: Any) {
        dismiss(animated: true)
    }
    
    @IBAction func verifybtnTapped(_ sender: Any) {
        let text1 = text1.text!
        let text2 = text2.text!
        let text3 = text3.text!
        let text4 = text4.text!
    
       let combine = text1  +  text2 +  text3  +  text4
       //let otps = otpverification
        let otps = getOtp
        print(combine)
        if combine != otps{
           
            print("Not veryfied")
            print(otpResponses)
            let images = UIImage(systemName: "gear")
            let alart = UIAlertController(title: "Not Verrified!!", message: "Re-enter your OTP ", preferredStyle: .alert)
            
            let closeBtn = UIAlertAction(title: "CLose", style: UIAlertAction.Style.cancel,handler: {action in
                print("Close")
            })
            alart.addAction(closeBtn)
            self.present(alart, animated: true,completion: nil)
        }else{
           
            print("verified")
            let images = UIImage(systemName: "gear")
            let alart = UIAlertController(title: "Verrified!!", message: "", preferredStyle: .alert)
            
            let closeBtn = UIAlertAction(title: "CLose", style: UIAlertAction.Style.cancel,handler: {action in
                
                    self.performSegue(withIdentifier: "createNew", sender: self)
                    //self.dismiss(animated: true)
             
            })
            alart.addAction(closeBtn)
            self.present(alart, animated: true,completion: nil)
        }
       
    }
    
    @IBAction func fieldChenged(_ sender: Any) {
        checkValidation()
    }
    
    func checkValidation(){
        
    }
    func parameters(){
       
        var sendDataToAPI = [String:Any]()
        sendDataToAPI["fname"] = fname
        sendDataToAPI["middlenames"] = middlenames
        sendDataToAPI["lastname"] = lastname
        sendDataToAPI["dateofbirth"] = dateofbith
        sendDataToAPI["genders"] = genders
        sendDataToAPI["occupation"] = occupation
        sendDataToAPI["permanent_address"] = permanent_address
        sendDataToAPI["current_address"] = current_address
        sendDataToAPI["email_address"] = email_address
        sendDataToAPI["pincode"] = pincode
        sendDataToAPI["country"] = country
        sendDataToAPI["state"] = state
        sendDataToAPI["city"] = city
        sendDataToAPI["areaofResident"] = areaofResident
        sendDataToAPI["areaofResident"] = phone_no
        
    }
}
