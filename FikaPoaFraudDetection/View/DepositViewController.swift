//
//  DepositViewController.swift
//  FikaPoaFraudDetection
//
//  Created by SOFTWARE on 07/03/2023.
//

import UIKit
import Combine

@available(iOS 13.0, *)
class DepositViewController: UIViewController {
    
    let url = "http://localhost:3001/Users"
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        
        //setMockProtocol()
        navigationItem.hidesBackButton = true
        // Do any additional setup after loading the view.
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "gear"), style: .plain, target: self, action: #selector(showSetting(_ :)))
        //GetData(from: url)
        
    }
    
    //fetching data from api
    func getData(){
        guard let url = URL(string: "http://localhost:3001/Users") else{return}
        URLSession.shared.dataTask(with: url){ data ,response,error in
            if let error = error{
                print("There is any error",error.localizedDescription)
            } else{
                let json = try? JSONSerialization.jsonObject(with: data!,options: [])
               if let dataApi = json as? [String:Any],
                let dataString = dataApi [ "data"] as? [String:Any]{
                    print(dataString)
                }
                //print("The response data:",json!)
            }
        }.resume()
    }
    //save data to api
    
    func saveData(){
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else{return}
        let params = [
            "title":"Ali",
            "body":"Test"
        ]
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("Application/Json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try? JSONSerialization.data(withJSONObject: params,options: [])
        
        URLSession.shared.dataTask(with: request){data,response,error in
            if let error = error{
                print("There is an error:",error.localizedDescription)
            }else{
                let json = try? JSONSerialization.jsonObject(with: data!,options: [])
                print("There is an error:",json!)
            }
        }.resume()
    }
    
    @objc
    private func showSetting(_ sender:UIBarButtonItem){
        print("show settings")
    }
    private func GetData(from url : String){
        let task = URLSession.shared.dataTask(with: URL(string: url)!, completionHandler: { data,response,error in
            guard let data = data,error == nil else{
                print("something went wrong")
                return
            }
                //returning data
            var result:Response!
            do{
                result = try JSONDecoder().decode(Response.self, from: data)
                
            }catch{
                print("Fail to decode data from api",error.localizedDescription)
            }
            guard let json = result else{
                return
            }
            print(json.result.Country)
            
       })
        task.resume()
    }
    
    // MARK: - Navigation

    @IBAction func backBtn_Tapped(_ sender: UIBarButtonItem) {
        if let navigationController = self.navigationController,
                let homeViewController = navigationController.viewControllers.first(where: { $0 is HomeViewController }) {
                    navigationController.popToViewController(homeViewController, animated: true)
            if let homeVC = self.presentingViewController as? HomeViewController {
                            homeVC.closeMenu()
                        }
            }
             
         }
    
    
}
struct Response:Codable{
    let result: Myresult
}
struct  Myresult:Codable{
    let first_name :String
    let mname :String
    let last_name: String
    let email: String
    let gender: String
    let dateofbirth: String
    let phone_no: String
    let permanentAddress: String
    let CurrentAddress: String
    let Occupation: String
    let pincode: String
    let AreaofResident:String
    let City: String
    let status:String
    let Country: String
}
