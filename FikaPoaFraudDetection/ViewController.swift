//
//  ViewController.swift
//  FikaPoaFraudDetection
//
//  Created by SOFTWARE on 02/03/2023.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var RegistrationButton: UIButton!
    @IBOutlet weak var LoginButton: UIButton!
    
    @IBOutlet weak var title1: UILabel!
    
    @IBOutlet weak var title3: UILabel!
    @IBOutlet weak var title2: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        let fontTitle1 = UIFont(name: "TimesNewRomanPS-BoldMT", size: 30)
        let fontTitle2 = UIFont(name: "TimesNewRomanPS-BoldMT", size: 24)
        let fontTitle3 = UIFont(name: "TimesNewRomanPS-BoldMT",size: 17)
        title1.font = fontTitle1
        title2.font = fontTitle2
        title3.font = fontTitle3
        Design()
    }

    @IBAction func registrationButonTaped(_ sender: Any) {
        performSegue(withIdentifier: "registrationButton", sender: self)
    }
    @IBAction func LoginBtnTaped(_ sender: Any) {
        performSegue(withIdentifier: "loginButton", sender: self)
    }
    func Design(){
        LoginButton.layer.cornerRadius = 50
        RegistrationButton.layer.cornerRadius = 50
    }
}

