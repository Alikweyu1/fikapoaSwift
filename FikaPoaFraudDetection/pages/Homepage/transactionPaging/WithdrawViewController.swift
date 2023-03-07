//
//  WithdrawViewController.swift
//  FikaPoaFraudDetection
//
//  Created by SOFTWARE on 21/03/2023.
//

import UIKit
import Reachability
class WithdrawViewController: UIViewController {
    var reachability = try! Reachability()
    @IBOutlet weak var nextbtn: UIButton!
    
    @IBOutlet weak var deposit: UIButton!
    @IBOutlet weak var passwordlbl: UITextField!
    @IBOutlet weak var amount: UITextField!
    @IBOutlet weak var titlelable: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        passwordlbl .isHidden = true
        deposit.isHidden = true
        
        // Do any additional setup after loading the view.
    }
    

    
    @IBAction func closeTaaped(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    @IBAction func nextTapped(_ sender: Any) {
        amount.isHidden = true
        
        nextbtn.isHidden = true
        passwordlbl.isHidden = false
        deposit .isHidden = false
    }
    @IBAction func depositTapped(_ sender: Any) {
        do{
            self.reachability = try Reachability.init()
        } catch{
            print("fail to start notifier")
        }
        if ((reachability.connection) != .unavailable){
            let dataDeposit = createParameters()
            guard let url = URL(string: "http://localhost:3001/withdraw") else{return}
            var request = URLRequest(url: url)
            do{
                request.httpMethod = "POST"
                request.setValue("application/json", forHTTPHeaderField: "Content-Type")
                request.httpBody = try JSONSerialization.data(withJSONObject: dataDeposit,options:[])
                URLSession.shared.dataTask(with: request){ data,response,error in
                    if let error = error{
                        print(error.localizedDescription)
                    }else{
                        //decode the response from the server
                        DispatchQueue.main.async {
                            let alert = UIAlertController(title: "Json data received!!", message: "Waiting for Api response", preferredStyle: .alert)
                            let ok = UIAlertAction(title: "Ok", style: UIAlertAction.Style.cancel,handler: { action in
                                
                            })
                            alert.addAction(ok)
                            self.present(alert, animated: true)
                        }
                    }
                }.resume()
            }catch{
                print("fail  to Connect to the server")
            }
        }
    }
    
    func createParameters() -> [String:Any]{
        var parameters = [ String:Any]()
        parameters["Amount"] = amount.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        parameters["Pin"] = passwordlbl.text!.trimmingCharacters(in: .newlines)
        let phoneNumber = UserDefaults.standard.string(forKey: "phone")
        parameters["MobileNumber"] = phoneNumber
        return parameters
    }
}
