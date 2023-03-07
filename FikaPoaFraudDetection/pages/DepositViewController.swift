//
//  DepositViewController.swift
//  FikaPoaFraudDetection
//
//  Created by SOFTWARE on 07/03/2023.
//

import UIKit

class DepositViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.hidesBackButton = true
        // Do any additional setup after loading the view.
    }
    

    
    // MARK: - Navigation

     @IBAction func backBtn_Tapped(_ sender: UIBarButtonItem) {
         if let mainPage = storyboard?.instantiateViewController(withIdentifier: "HomeViewController") as? HomeViewController{
             navigationController?.pushViewController(mainPage, animated: true)
         }
         
     }
    
}
