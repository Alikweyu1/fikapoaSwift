//
//  Deposit1ViewController.swift
//  FikaPoaFraudDetection
//
//  Created by SOFTWARE on 31/03/2023.
//

import UIKit
import Reachability
class Deposit1ViewController: UIViewController {
    var reachability = try! Reachability()
    @IBOutlet weak var pin: UITextField!
   
    @IBOutlet weak var next3: UIButton!
    @IBOutlet weak var deposit: UIButton!
    @IBOutlet weak var next2: UIButton!
    @IBOutlet weak var next1: UIButton!
    @IBOutlet weak var storeNuTxt: UITextField!
    @IBOutlet weak var agenttxt: UITextField!
    @IBOutlet weak var amounttxt: UITextField!
    @IBOutlet weak var deposittxt: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        amounttxt.isHidden = true
        storeNuTxt.isHidden = true
        deposit.isHidden = true
        next2.isHidden = true
        pin.isHidden = true
        next3.isHidden = true
        // Do any additional setup after loading the view.
    }
    

    @IBAction func xtapped(_ sender: Any) {
        self.dismiss(animated: true)
    }
    

    
    @IBAction func next1Tapped(_ sender: Any) {
        agenttxt.isHidden = true
        amounttxt.isHidden = true
        storeNuTxt.isHidden = false
        deposit.isHidden = true
        next1.isHidden = true
        next2.isHidden = false
        next3.isHidden = true
        
    }
    @IBAction func next2Tapped(_ sender: Any) {
        agenttxt.isHidden = true
        amounttxt.isHidden = false
        storeNuTxt.isHidden = true
        deposit.isHidden = true
        next1.isHidden = true
        next2.isHidden = true
        next3.isHidden = false
    }
    @IBAction func next3Taaped(_ sender: Any) {
        agenttxt.isHidden = true
        amounttxt.isHidden = true
        storeNuTxt.isHidden = true
        deposit.isHidden = false
        next1.isHidden = true
        next2.isHidden = true
        next3.isHidden = true
        pin.isHidden = false
    }
    
    @IBAction func depositTapped(_ sender: Any) {
        do{
            self.reachability = try Reachability.init()
        } catch{
            print("fail to start notifier")
        }
        if ((reachability.connection) != .unavailable){
            let dataDeposit = createParameters()
            guard let url = URL(string: "http://localhost:3001/deposit") else{return}
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
        parameters["AgentNumber"] = agenttxt.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        parameters["StoreNumber"] = storeNuTxt.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        parameters["Amount"] = amounttxt.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        parameters["Pin"] = pin.text!.trimmingCharacters(in: .newlines)
        let phoneNumber = UserDefaults.standard.string(forKey: "phone")
        parameters["MobileNumber"] = phoneNumber
        return parameters
    }
}
