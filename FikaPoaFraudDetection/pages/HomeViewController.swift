//
//  HomeViewController.swift
//  FikaPoaFraudDetection
//
//  Created by SOFTWARE on 06/03/2023.
//

import UIKit

class HomeViewController: UIViewController {
    var menu_vc : MenuViewController!
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "FikaPoa Fraud Detection"
        let titleAttributes = [NSAttributedString.Key.foregroundColor: UIColor(red: 0.9098, green: 0.1961, blue: 0.9608, alpha: 1.0),NSAttributedString.Key.font: UIFont(name: "TimesNewRomanPS-BoldMT", size: 20)!
        ]
            navigationController?.navigationBar.titleTextAttributes = titleAttributes
        navigationItem.hidesBackButton = true
        menu_vc = storyboard?.instantiateViewController(withIdentifier: "MenuViewController") as? MenuViewController
    }
    
    // MARK: - Navigation
    @IBAction func menu_action_tapped(_ sender: UIBarButtonItem) {
        if AppDelegate.menu_bool{
            //opening side menu
            showMenu()
        }else{
            //clossing side menu
            closeMenu()
        }
    }
    
    func showMenu(){
        self.menu_vc.view.backgroundColor = UIColor(red: 0.9098, green: 0.1961, blue: 0.9608, alpha: 1.0)
        self.addChild(menu_vc)
        self.view.addSubview(menu_vc.view)
        AppDelegate.menu_bool = false
    }
    
    func closeMenu(){
        self.menu_vc.view.removeFromSuperview()
        AppDelegate.menu_bool = true
    }
    

}
