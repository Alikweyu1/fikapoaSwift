//
//  FogetPasswordViewController.swift
//  FikaPoaFraudDetection
//
//  Created by SOFTWARE on 06/03/2023.
//

import UIKit

class FogetPasswordViewController: UIViewController {

    @IBOutlet weak var phone_no: UITextField!
    let lineColor = UIColor(red: 0.9098, green: 0.1961, blue: 0.9608, alpha: 1.0)
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "create Password"
        self.phone_no.addBottomBorderLinewithColor(Color: lineColor, width: 1)
    }
    

    
    // MARK: - Navigation

     @IBAction func NextBtnTapped(_ sender: Any) {
         performSegue(withIdentifier: "createNewPassword", sender: self)
     }
    

}
