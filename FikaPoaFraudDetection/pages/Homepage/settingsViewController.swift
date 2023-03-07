//
//  settingsViewController.swift
//  FikaPoaFraudDetection
//
//  Created by SOFTWARE on 14/03/2023.
//

import UIKit
import Reachability
class settingsViewController: UIViewController {
    @IBOutlet weak var pasonalLbl: UILabel!
    
    @IBOutlet weak var addressLbl: UILabel!
    @IBOutlet weak var contactInfor: UILabel!
    @IBOutlet weak var countries: UILabel!
    @IBOutlet weak var cities: UILabel!
    @IBOutlet weak var arreaofResdent: UILabel!
    @IBOutlet weak var pinCode: UILabel!
    @IBOutlet weak var cAddresses: UILabel!
    @IBOutlet weak var paddresses: UILabel!
    @IBOutlet weak var addressView: UIView!
    @IBOutlet weak var contactView: UIView!
    @IBOutlet weak var occupationLb: UILabel!
    @IBOutlet weak var phoneNo: UILabel!
    @IBOutlet weak var dobs: UILabel!
    @IBOutlet weak var genders: UILabel!
    @IBOutlet weak var emailAddres: UILabel!
    @IBOutlet weak var fullnamelbl: UILabel!
    @IBOutlet weak var view1: UIView!
    @IBOutlet weak var imageProfile: UIImageView!
    let lineColor = UIColor(red: 0.9098, green: 0.1961, blue: 0.9608, alpha: 1.0)
    private let floatngUpdateBtn:UIButton = {
        let Colors = UIColor(red: 0.9098, green: 0.1961, blue: 0.9608, alpha: 1.0)
        let Button = UIButton(frame: CGRect(x: 0, y: 0, width: 60, height: 60))
        //Button.layer.masksToBounds = true
        Button.layer.cornerRadius = 30
        Button.layer.shadowRadius = 10
        Button .layer.shadowOpacity = 1
        Button.tintColor = .white
        
        Button.setTitle("Edit", for: .normal)
        
        Button.setTitleColor(.white, for: .normal)
        Button.backgroundColor = Colors
        return Button
    }()
    var reachability = try! Reachability()
    override func viewDidLoad() {
        super.viewDidLoad()
        imageProfile.isHidden = true
        // view1
        self.view1.verticalBorderLinewithColor(color: lineColor, width: 1)
        self.view1.verticalBorderLineRightwithColor(color: lineColor, width: 1)
        self.view1.addBottomBorderLinewithColor(Color: lineColor, width: 1)
        
       
        //contactView
        self.contactView.verticalBorderLinewithColor(color: lineColor, width: 1)
        self.contactView.verticalBorderLineRightwithColor(color: lineColor, width: 1)
        self.contactView.addBottomBorderLinewithColor(Color: lineColor, width: 1)
        
        //addressView
        self.addressView.verticalBorderLinewithColor(color: lineColor, width: 1)
        self.addressView.verticalBorderLineRightwithColor(color: lineColor, width: 1)
        self.addressView.addBottomBorderLinewithColor(Color: lineColor, width: 1)
        
        self.pasonalLbl .addBottomBorderLinewithColor(Color: lineColor, width: 1)
        self.contactInfor.addBottomBorderLinewithColor(Color: lineColor, width: 1)
        self.addressLbl.addBottomBorderLinewithColor(Color: lineColor, width: 1)
        paddresses.sizeToFit()
        //view.addSubview(floatngUpdateBtn)
        floatngUpdateBtn.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        details()
        
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        floatngUpdateBtn.frame = CGRect(x: view.frame.size.width - 70, y: view.frame.size.height - 70, width: 60, height: 60)
    }
    @objc private func didTapButton(){
        do{
            self.reachability = try Reachability.init()
        } catch{
            print("Fail to start Notifier")
        }
        if((reachability.connection) != .unavailable){
            let editpageView = storyboard?.instantiateViewController(withIdentifier: "")
        }else{
            let alart = UIAlertController(title: "Netwok error", message: "Check your internet", preferredStyle: .alert)
            
            let closeBtn = UIAlertAction(title: "CLose", style: UIAlertAction.Style.cancel,handler: {action in
                print("Close")
            })
            alart.addAction(closeBtn)
            self.present(alart, animated: true,completion: nil)
        }
            
        }
    func details(){
        view.layer.cornerRadius = 3
        imageProfile.layer.masksToBounds = true
        imageProfile.layer.cornerRadius = imageProfile.frame.height / 2
        
        
        
        if let firstName = UserDefaults.standard.string(forKey: "firstname"),
           let middleName = UserDefaults.standard.string(forKey: "middlename"),
           let lastName = UserDefaults.standard.string(forKey: "lastname"),
            let email = UserDefaults.standard.string(forKey: "useremail"),
           let gender = UserDefaults.standard.string(forKey: "gender"),
           //let dateofbirth = UserDefaults.standard.string(forKey: "dateofbirth"),
        
       let dob = UserDefaults.standard.string(forKey: "dob"),
           let phoneNumber = UserDefaults.standard.string(forKey: "phone"),
           let occupation = UserDefaults.standard.string(forKey: "occupation"),
           //addresses
           let paddress = UserDefaults.standard.string(forKey: "permanentAddress"),
           let cAddress = UserDefaults.standard.string(forKey: "currentAddress"),
           let pinCodes = UserDefaults.standard.string(forKey: "picode"),
           let areaofResdents = UserDefaults.standard.string(forKey: "areaofResident"),
           let city = UserDefaults.standard.string(forKey: "city"),
           let country = UserDefaults.standard.string(forKey: "country")
        {
               fullnamelbl.text = firstName + " " + middleName + " " + lastName
            genders.text = "Gender" + ":" + gender
           
            emailAddres.text = "Email" + ":" + email
            dobs.text = "Date of birth" + ":" + dob
            phoneNo.text = "Mobile" + ":" + phoneNumber
            occupationLb.text = "Occupation" + ":"
            + occupation
            paddresses.text = "Permanent address" + ":" + paddress
            cAddresses.text = "Current adrress" + ":" + cAddress
            pinCode.text = "Pin Code" + ":" + pinCodes
            arreaofResdent.text = "Are of resident" + ":" + areaofResdents
            cities.text = "City" + ":" + city
           countries.text = "Country" + ":" + country
            
        } else {
               // handle error case where values are not strings or are not set
        }
        
        
        
    }

}
