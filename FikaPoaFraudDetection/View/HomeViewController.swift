//
//  HomeViewController.swift
//  FikaPoaFraudDetection
//
//  Created by SOFTWARE on 06/03/2023.
//

import UIKit

@available(iOS 13.0, *)
class HomeViewController: UIViewController {
    var menu_vc : MenuViewController!
    let currentData = UserModel.shared.currentUser
    @IBOutlet weak var progileView: UIView!
    
    @IBOutlet weak var SlideView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        print(currentData?.firstname ?? "no data") 
        title = "Hi"
        //design()
        //scrolling
        /*let scrollView = UIScrollView(frame: CGRect(x: 0, y: SlideView.frame.maxY, width: view.frame.width, height: SlideView.frame.height))
        view.addSubview(scrollView)
        let CreateImage = [
            UIImage(named: "mpesa"),UIImage(named: "A2M"), UIImage(named: "mpesa")]
        for i in 0..<CreateImage.count {
                    let imageView = UIImageView(image: CreateImage[i])
                    imageView.frame = CGRect(x: SlideView.frame.width * CGFloat(i), y: 0, width: SlideView.frame.width, height: SlideView.frame.height)
                    scrollView.addSubview(imageView)
                }
         
        scrollView.contentSize = CGSize(width: SlideView.frame.width * CGFloat(CreateImage.count), height: SlideView.frame.height)
         */
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
        UIView.animate(withDuration: 0.3,delay: 0){  () -> Void in
            self.menu_vc.view.frame = CGRect(x: 0, y: 60, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
            self.menu_vc.view.backgroundColor = UIColor.black.withAlphaComponent(0.3)
            self.addChild(self.menu_vc)
            self.view.addSubview(self.menu_vc.view)
            
            
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
    /*func design(){
        progileView.layer.cornerRadius = 20
        progileView.sizeToFit()
    }
     */

}
