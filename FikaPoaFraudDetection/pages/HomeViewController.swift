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
        let rightSwift = UISwipeGestureRecognizer(target: self, action: #selector(self.responseGesture))
        rightSwift.direction = UISwipeGestureRecognizer.Direction.right
        
        let leftSwift = UISwipeGestureRecognizer(target: self, action: #selector(self.responseGesture))
        leftSwift.direction = UISwipeGestureRecognizer.Direction.left
        
        
        self.view.addGestureRecognizer(rightSwift)
        self.view.addGestureRecognizer(leftSwift)
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
    @objc func responseGesture(gesture: UISwipeGestureRecognizer){
        switch gesture.direction{
        case UISwipeGestureRecognizer.Direction.right:
            showMenu()
        case UISwipeGestureRecognizer.Direction.left:
            closeMenu()
        default:
            closeMenu()
        }
    }
    func showMenu(){
        UIView.animate(withDuration: 0.3,delay: 0,usingSpringWithDamping: 0.8,initialSpringVelocity: 0,options: .curveEaseInOut){  () -> Void in
            self.menu_vc.view.frame = CGRect(x: 0, y: 60, width: UIScreen.main.bounds.width-50, height: UIScreen.main.bounds.height-20)
            self.menu_vc.view.backgroundColor = UIColor.black.withAlphaComponent(0.3)
            self.addChild(self.menu_vc)
            self.view.addSubview(self.menu_vc.view)
            
            // Move the HomeViewController's superview to the left
            self.view.superview?.frame = CGRect(x: self.menu_vc.view.frame.size.width, y: self.view.superview?.frame.origin.y ?? 0, width: self.view.superview?.frame.size.width ?? 0, height: self.view.superview?.frame.size.height ?? 0)
            
            self.menu_vc.didMove(toParent: self)
            AppDelegate.menu_bool = false
        }
    }

    
    func closeMenu(){
        UIView.animate(withDuration: 0.3,delay:0,animations: { () -> Void in
            self.menu_vc.view.frame = CGRect(x: -UIScreen.main.bounds.width, y: 60, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        }){(Finished) in
            self.menu_vc.view.removeFromSuperview()
        }
        
        AppDelegate.menu_bool = true
    }
    

}
