//
//  LoginViewController.swift
//  FikaPoaFraudDetection
//
//  Created by SOFTWARE on 02/03/2023.
//

import UIKit

class LoginViewController: UIViewController {
    @IBOutlet weak var phone_no: UITextField!
    
    @IBOutlet weak var password: UITextField!
    let lineColor = UIColor(red: 0.9098, green: 0.1961, blue: 0.9608, alpha: 1.0)
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Login"
        self.phone_no.addBottomBorderLinewithColor(Color: lineColor, width: 1)
        self.password.addBottomBorderLinewithColor(Color: lineColor, width: 1)
        
        
        
    }
    

    
    
    // MARK: - Navigation

    @IBAction func forgetPasswordTapped(_ sender: Any) {
       performSegue(withIdentifier: "forgetPassword", sender: self)
    }

    @IBAction func logiClicked(_ sender: Any) {
        if let mainPage = storyboard?.instantiateViewController(withIdentifier: "HomeViewController") as? HomeViewController{
            navigationController?.pushViewController(mainPage, animated: true)
        }
    }
}
