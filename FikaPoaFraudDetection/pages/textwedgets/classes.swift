//
//  classes.swift
//  FikaPoaFraudDetection
//
//  Created by SOFTWARE on 18/03/2023.
//

import Foundation
import MBProgressHUD
class Classes:UIViewController{
    private var progressHUD: MBProgressHUD?
    func showProgressHUD() {
        progressHUD = MBProgressHUD.showAdded(to: self.view, animated: true)
            progressHUD?.mode = .indeterminate
            progressHUD?.label.text = "Loading please wait ..."
        }
        
        func hideProgressHUD() {
            progressHUD?.hide(animated: true)
        }
    
}
