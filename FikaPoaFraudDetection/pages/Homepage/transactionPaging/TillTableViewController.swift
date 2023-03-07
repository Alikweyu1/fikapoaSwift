//
//  TillTableViewController.swift
//  FikaPoaFraudDetection
//
//  Created by SOFTWARE on 16/03/2023.
//

import UIKit
import MBProgressHUD
class TillTableViewController: UITableViewController, UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        
    }
    
    private var progressHUD: MBProgressHUD?
    private let floatngUpdateBtn:UIButton = {
        let Colors = UIColor(red: 0.9098, green: 0.1961, blue: 0.9608, alpha: 1.0)
        let Button = UIButton(frame: CGRect(x: 0, y: 0, width: 60, height: 60))
        //Button.layer.masksToBounds = true
        Button.layer.cornerRadius = 30
        Button.layer.shadowRadius = 10
        Button .layer.shadowOpacity = 1
        Button.tintColor = .white
        
        Button.setTitle("Send", for: .normal)
        
        Button.setTitleColor(.white, for: .normal)
        Button.backgroundColor = Colors
        return Button
    }()
   
let reuseIdentifies = "listoftill"
    var transaction: [transaction]?{
        didSet{
            DispatchQueue.main.async { [self] in
                tableView.reloadData()
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        let searchController = UISearchController(searchResultsController: nil)
            searchController.searchResultsUpdater = self
            searchController.obscuresBackgroundDuringPresentation = false
            searchController.searchBar.placeholder = "Search Transactions"
            navigationItem.searchController = searchController
            definesPresentationContext = true
            tableView.estimatedRowHeight = 100
            // Set the row height to automatic
        tableView.rowHeight = UITableView.automaticDimension
       // tableView.addSubview(floatngUpdateBtn)
        //floatngUpdateBtn.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        config()
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let buttonSize: CGFloat = 60
        let buttonMargin: CGFloat = 10
        let buttonX = tableView.frame.maxX - buttonSize - buttonMargin
        let buttonY = tableView.frame.maxY - buttonSize - buttonMargin
        //floatngUpdateBtn.frame = CGRect(x: buttonX, y: buttonY, width: buttonSize, height: buttonSize)
    }
    @objc func didTapButton(){
        performSegue(withIdentifier: "sent", sender: self)
    }
    // MARK: - Table view data source
    func config(){
        tableView.backgroundColor = .lightGray
        showProgressHUD()
        let transactions = TillTransaction()
        transactions.fetchTillTransactionList{(tills) in
            DispatchQueue.main.async { [self ] in
                self.navigationItem.title = tills.PartA
                hideProgressHUD()
            }
            self.transaction = tills.transaction
            
        }
    }
   
    func showProgressHUD() {
            progressHUD = MBProgressHUD.showAdded(to: self.view, animated: true)
            progressHUD?.mode = .indeterminate
            progressHUD?.label.text = "Loading please wait ..."
        }
        
        func hideProgressHUD() {
            progressHUD?.hide(animated: true)
        }

}
extension TillTableViewController{
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return transaction?.count ?? 0
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifies, for: indexPath)
        guard   let list = transaction?[indexPath.row] else{return UITableViewCell()}
        cell.textLabel?.text = "\(indexPath.row + 1). Sent to :\(list.PartB)  |Amount \(list.amount) | date \(list.Timestamps)"
        cell.textLabel?.numberOfLines = 0
            cell.textLabel?.lineBreakMode = .byWordWrapping
        return cell
    }
}
