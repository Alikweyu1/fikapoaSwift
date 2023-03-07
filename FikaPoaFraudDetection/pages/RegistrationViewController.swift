//
//  RegistrationViewController.swift
//  FikaPoaFraudDetection
//
//  Created by SOFTWARE on 02/03/2023.
//

import UIKit
import MBProgressHUD
import Reachability
import Alamofire
class RegistrationViewController: UIViewController,UITableViewDelegate,UITextFieldDelegate,UITableViewDataSource {

    
    
    @IBOutlet weak var dateview: UIView!
    @IBOutlet weak var occupation: UITextField!
    @IBOutlet weak var dateofbirth: UIDatePicker!
    @IBOutlet weak var lname: UITextField!
    @IBOutlet weak var mname: UITextField!
    @IBOutlet weak var fname: UITextField!
    
   
    @IBOutlet weak var nextbutton: UIButton!
    @IBOutlet weak var tblDropdown: UITableView!
  
    @IBOutlet weak var tabledropDownHc: NSLayoutConstraint!
   let lineColor = UIColor(red: 0.9098, green: 0.1961, blue: 0.9608, alpha: 1.0)
    var isTableVisible = false
    
    @IBOutlet weak var selectedname: UIButton!
    let reachabilityManager = Alamofire.NetworkReachabilityManager(host: "www.apple.com")
    let networkStatusView = NetworkView()
    let nameCharacter = CharacterSet.letters
    let occupationCharacters = CharacterSet.alphanumerics.union(CharacterSet(charactersIn: "_ ' "))
    override func viewDidLoad() {
        super.viewDidLoad()
        fname.delegate = self
        
        
title = "Registration "
      
        checkNetworkStatus()
        self.fname.addBottomBorderLinewithColor(Color: lineColor, width: 1)
        fname.autocorrectionType = .no
        fname.autocapitalizationType = .words
        self.mname.addBottomBorderLinewithColor(Color: lineColor, width: 1)
        mname.autocorrectionType = .no
        mname.autocapitalizationType = .words
        self.lname.addBottomBorderLinewithColor(Color: lineColor, width: 1)
        lname.autocorrectionType = .no
        lname.autocapitalizationType = .words
        self.occupation.addBottomBorderLinewithColor(Color: lineColor, width: 1)
        occupation.autocorrectionType = .no
        occupation.autocapitalizationType = .words
        self.dateview.addBottomBorderLinewithColor(Color: lineColor, width: 1)
        
        
        tblDropdown.delegate = self
        tblDropdown.dataSource = self
        tabledropDownHc.constant = 0
        
        
        
        checkFields()
        
        
        let currentDate = Date()
            let eighteenYearsAgo = Calendar.current.date(byAdding: .year, value: -18, to: currentDate)!
        
            dateofbirth.maximumDate = eighteenYearsAgo
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super .didReceiveMemoryWarning()
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "Select gender")
        if cell == nil{
            cell = UITableViewCell(style: .default, reuseIdentifier: "gender")
            
        }
        switch indexPath.row {
            case 0:
                cell?.textLabel?.text = "Male"
            case 1:
                cell?.textLabel?.text = "Female"
            case 2:
                cell?.textLabel?.text = "Other"
            default:
                cell?.textLabel?.text = " "
            }
            
            return cell!
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if let cell = tableView.cellForRow(at: indexPath),
        let selectedName = cell.textLabel?.text {
            print("You have selected: \(selectedName)")
                    selectedname.setTitle(selectedName, for: .normal)
        }
        switch indexPath.row {
            case 0:
                selectedname.setTitle("Male", for: .normal)
            
            case 1:
                selectedname.setTitle("Female", for: .normal)
            case 2:
                selectedname.setTitle("Other", for: .normal)
            default:
                selectedname.setTitle(" ", for: .normal)
            }
            UIView.animate(withDuration: 0.5) {
                self.tabledropDownHc.constant = 0
                self.isTableVisible = false
                self.view.layoutIfNeeded()
            }
    }
    @IBAction func selectGender(_ sender: AnyObject) {
        UIView.animate(withDuration: 0.5){
            if self.isTableVisible == false{
                self.isTableVisible = true
                self.tabledropDownHc.constant = 44.0 * 3.0
            }else{
                self.tabledropDownHc.constant = 0
                self.isTableVisible = false
            }
            self.view.layoutIfNeeded()
        }
        
    }
    
    
    //didEditingEnd
    
    @IBAction func checkValidateionWhenTextEnds(_ sender: Any) {
        
    }
    
    
    @IBAction func editingEndsOnExit(_ sender: Any) {
        
    }
    @IBAction func nextClicked(_ sender: Any) {
        performSegue(withIdentifier: "generalToContact", sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let distination = segue.destination as? ContactViewController{
            distination.fname = fname.text
            distination.middlenames = mname.text
            distination.lastname = lname.text
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            distination.dateofbith = dateFormatter.string(from: dateofbirth.date)
            distination.genders = selectedname.currentTitle
            distination.occupation = occupation.text
        }
    }
    
    
    //Delegate Check
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == lname {
            let validCharacters = CharacterSet.letters
            let newString = (textField.text as NSString?)?.replacingCharacters(in: range, with: string) ?? ""
            let isValid = newString.rangeOfCharacter(from: validCharacters.inverted) == nil
    
            if !isValid {
                let alert = UIAlertController(title: "Invalid Input", message: "Please enter only letters.", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                alert.addAction(okAction)
                present(alert, animated: true, completion: nil)
            }
        }   else if  textField == mname {
            let validCharacters = CharacterSet.letters
            let newString = (textField.text as NSString?)?.replacingCharacters(in: range, with: string) ?? ""
            let isValid = newString.rangeOfCharacter(from: validCharacters.inverted) == nil
    
            if !isValid {
                let alert = UIAlertController(title: "Invalid Input", message: "Please enter only letters.", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                alert.addAction(okAction)
                present(alert, animated: true, completion: nil)
            }
        }
        
        return true
    }
    func checkFields() {
        // Disable the submit button if any of the required fields are empty
        if fname.text == "" || mname.text == "" || lname.text == "" || occupation.text == "" {
                nextbutton.isEnabled = false
                return
            }

            // Validate the first name
            let fnameRegex = "^[A-Za-z\\s]+$"
            let fnameTest = NSPredicate(format:"SELF MATCHES %@", fnameRegex)
            if !fnameTest.evaluate(with: fname.text) {
                showError("First name contains invalid characters")
                nextbutton.isEnabled = false
                return
                
            }

            // Validate the middle name
            let mnameRegex = "^[A-Za-z\\s]*$"
            let mnameTest = NSPredicate(format:"SELF MATCHES %@", mnameRegex)
            if !mnameTest.evaluate(with: mname.text) {
                showError("Middle name contains invalid characters")
                return
            }

            // Validate the last name
            let lnameRegex = "^[A-Za-z\\s]+$"
            let lnameTest = NSPredicate(format:"SELF MATCHES %@", lnameRegex)
            if !lnameTest.evaluate(with: lname.text) {
                showError("Last name contains invalid characters")
                return
            }

            // Enable the submit button if all fields are valid
            nextbutton.isEnabled = true
    }
   
    @IBAction func fieldEdited(_ sender: UITextField) {
        checkFields()
    }
    func checkNetworkStatus() {
        let reachability = try? Reachability()
        if let connection = reachability?.connection {
            switch connection {
            case .wifi:
                networkStatusView.setProgress(1, animated: true)
                networkStatusView.showMessage("Connected to WiFi")
            case .cellular:
                networkStatusView.setProgress(1, animated: true)
                networkStatusView.showMessage("Connected to Cellular Data")
            case .unavailable:
                networkStatusView.setProgress(0, animated: true)
                networkStatusView.showMessage("No Network Connection")
            
            
            }
        } else {
            networkStatusView.setProgress(0, animated: true)
            
            
        }
    }
    func showError(_ message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
}
extension UIView{
    func addBottomBorderLinewithColor(Color:UIColor,width:CGFloat){
        let borderline = CALayer()
        borderline.backgroundColor = Color.cgColor
        borderline.frame = CGRect(x: 0, y: self.frame.size.height - width, width: self.frame.size.width, height: width)
        self.layer.addSublayer(borderline)
    }
}
