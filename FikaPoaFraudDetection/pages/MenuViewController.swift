//
//  MenuViewController.swift
//  FikaPoaFraudDetection
//
//  Created by SOFTWARE on 07/03/2023.
//

import UIKit

class MenuViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    @IBOutlet weak var menu_TableView: UITableView!
  var menuHome   : MenuViewController!
    let title_array = ["Home","Deposit","Transaction","Analysis","Setting","Logout"]
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
            if let mainPage = storyboard?.instantiateViewController(withIdentifier: "DepositViewController") as? DepositViewController{
                navigationController?.pushViewController(mainPage, animated: true)
            }
        case 2:
            performSegue(withIdentifier: "transaction", sender: self)
        default:
            break
        }
    }

    

}
