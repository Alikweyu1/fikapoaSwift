//
//  ViewController.swift
//  FikaPoaFraudDetection
//
//  Created by SOFTWARE on 02/03/2023.
//

import UIKit

@available(iOS 13.0, *)
class ViewController: UIViewController {
    let currentUser = UserModel.shared.currentUser
    @IBOutlet weak var RegistrationButton: UIButton!
    @IBOutlet weak var LoginButton: UIButton!
    
    @IBOutlet weak var logoImage: UIImageView!
    @IBOutlet weak var title1: UILabel!
    
    @IBOutlet weak var title3: UILabel!
    @IBOutlet weak var title2: UILabel!
    var devideIds = UIDevice.current.identifierForVendor?.uuidString ?? ""
    override func viewDidLoad() {
        super.viewDidLoad()
        logoImage.isHidden = true
        if UserDefaults.standard.value(forKey: "useremail") != nil{
            let hv = storyboard?.instantiateViewController(withIdentifier:"LipaViewController" ) as! LipaViewController
            navigationController?.pushViewController(hv, animated: true)
            print ("user is logged in")
        }else{
            print("user is not logged in")
        }
        let fontTitle1 = UIFont(name: "TimesNewRomanPS-BoldMT", size: 30)
        let fontTitle2 = UIFont(name: "TimesNewRomanPS-BoldMT", size: 24)
        let fontTitle3 = UIFont(name: "TimesNewRomanPS-BoldMT",size: 17)
        title1.font = fontTitle1
        title2.font = fontTitle2
        title3.font = fontTitle3
        Design()
    }
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = true
    }
    override func viewDidDisappear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = false
    }
    @IBAction func registrationButonTaped(_ sender: Any) {
        performSegue(withIdentifier: "registrationButton", sender: self)
    }
    @IBAction func LoginBtnTaped(_ sender: Any) {
        performSegue(withIdentifier: "loginButton", sender: self)
    }
    func Design(){
        LoginButton.layer.cornerRadius = 50
        LoginButton.layer.shadowColor = UIColor.black.cgColor
        LoginButton.layer.shadowOffset = CGSize(width: 0, height: 0)
        LoginButton.layer.shadowOpacity = 1
        LoginButton.layer.shadowRadius = 3
        
        
        RegistrationButton.layer.cornerRadius = 50
        RegistrationButton.layer.shadowColor = UIColor.black.cgColor
        RegistrationButton.layer.shadowOffset = CGSize(width: 0, height: 0)
        RegistrationButton.layer.shadowOpacity = 1
        RegistrationButton.layer.shadowRadius = 3
    }
    
}

