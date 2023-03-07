//
//  MenuViewController.swift
//  FikaPoaFraudDetection
//
//  Created by SOFTWARE on 07/03/2023.
//

import UIKit

@available(iOS 13.0, *)
class MenuViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    @IBOutlet weak var menu_TableView: UITableView!
  var menuHome   : MenuViewController!
    let title_array = ["","Transactions","Transactin Graph","Setting","Logout"]
    var homeController :HomeViewController!
    override func viewDidLoad() {
        super.viewDidLoad()
        menu_TableView.delegate = self
        menu_TableView.dataSource = self
    }
  
    // MARK: - Navigation
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return title_array.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "menu_cell") as! MenuTableViewCell
        cell.lable_title.text = title_array[indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        
            
        
        
        case 1:
            if let mainPage = storyboard?.instantiateViewController(withIdentifier: "TransactionController") as? TransactionController{
                navigationController?.pushViewController(mainPage, animated: true)
                if let homeVC = self.presentingViewController as? HomeViewController {
                                homeVC.closeMenu()
                            }
            }
       
        case 2:
            let test = UserDefaults.standard.value(forKey: "useremail")
            print(test)
            if let mainPage = storyboard?.instantiateViewController(withIdentifier: "AllTransactionViewController") as? AllTransactionViewController{
                navigationController?.pushViewController(mainPage, animated: true)
                if let homeVC = self.presentingViewController as? HomeViewController {
                    homeVC.closeMenu()
                }
            }
        case 3:
            let test = UserDefaults.standard.value(forKey: "useremail")
            print(test)
            if let mainPage = storyboard?.instantiateViewController(withIdentifier: "settingsViewController") as? settingsViewController{
                navigationController?.pushViewController(mainPage, animated: true)
                if let homeVC = self.presentingViewController as? HomeViewController {
                                homeVC.closeMenu()
                            }
                
            }
        case 4:
            UserDefaults.standard.removeObject(forKey: "useremail")
            UserDefaults.standard.removeObject(forKey: "dateofbirth")
            let hv = storyboard?.instantiateViewController(withIdentifier:"ViewController" ) as! ViewController
            navigationController?.pushViewController(hv, animated: true)
            
         
        default:
            break
        }
    }

    func logout() {
        UserDefaults.standard.removeObject(forKey: "deviceIdKey") // Remove device ID from UserDefaults
        // Destroy user session and take them to the login screen
        // ...
    }

}
