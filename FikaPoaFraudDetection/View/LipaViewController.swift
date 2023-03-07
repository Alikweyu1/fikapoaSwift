//
//  LipaViewController.swift
//  FikaPoaFraudDetection
//
//  Created by SOFTWARE on 13/03/2023.
//

import UIKit
import Charts
@available(iOS 13.0, *)
class LipaViewController: UIViewController {
    
    @IBOutlet weak var userProfileView: UIView!
    @IBOutlet weak var chartView:BarChartView!
    @IBOutlet weak var wbtn: UIButton!
    @IBOutlet weak var dbtn: UIButton!
    @IBOutlet weak var sbtn: UIButton!
    @IBOutlet weak var wView: UIView!
    @IBOutlet weak var sView: UIView!
    @IBOutlet weak var dView: UIView!
    @IBOutlet weak var view2: UIView!
    @IBOutlet weak var view1: UIView!
    @IBOutlet weak var myCollection: UICollectionView!
    var menus : MenuViewController!
    var displayImage = [UIImage(named: "disply1")!,UIImage(named: "display2")!,UIImage(named: "display3")!,UIImage(named: "display4")!,UIImage(named: "mpesa5")!]
   
    var currentIndex = 0
    var timer :Timer?
    @IBOutlet weak var myPageController: UIPageControl!
    override func viewDidLoad() {
        super.viewDidLoad()
        if let firstName = UserDefaults.standard.string(forKey: "firstname"),
           let middleName = UserDefaults.standard.string(forKey: "middlename"),
           let lastName = UserDefaults.standard.string(forKey: "lastname"){
            title = "Hi" + " " + firstName
            userProfileView.layer.cornerRadius = userProfileView.frame.width/2
                userProfileView.clipsToBounds = true
            dView.layer.cornerRadius = dView.frame.width/2
            dView.clipsToBounds = true
           sView.layer.cornerRadius = sView.frame.width/2
            sView.clipsToBounds = true
            wView.layer.cornerRadius = wView.frame.width/2
            wView.clipsToBounds = true
            view1.layer.shadowColor = UIColor.black.cgColor
            
           wbtn.currentTitle?.isEmpty
            dbtn.currentTitle?.isEmpty
           //view1
            view1.layer.shadowOpacity = 1
            view1.layer.shadowOffset = CGSize(width: 0, height: 3)
            view1.layer.shadowRadius = 3
            view1.layer.cornerRadius = 10
            //view2
             view2.layer.shadowOpacity = 1
             view2.layer.shadowOffset = CGSize(width: 0, height: 3)
             view2.layer.shadowRadius = 3
             view2.layer.cornerRadius = 10
            view1.layer.shadowColor = UIColor.black.cgColor
            navigationItem.hidesBackButton = false
            
        }
       
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName:"message.badge"), style: .plain, target: self, action: #selector(messages(_:)))
        myCollection.delegate = self
        myCollection.dataSource = self
        timer = Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(slideTonext), userInfo: nil, repeats: true)
        myPageController.numberOfPages = displayImage.count
        
        
        //font title
        
        let hometitle = [NSAttributedString.Key.foregroundColor:UIColor.black,NSAttributedString.Key.font:UIFont(name: "TimesNewRomanPS-BoldMT", size: 20)
                         ]
        navigationController?.navigationBar.titleTextAttributes = hometitle as [NSAttributedString.Key : Any]
        navigationItem.hidesBackButton = false
        
        menus = storyboard?.instantiateViewController(withIdentifier: "MenuViewController") as? MenuViewController
        let rightSwipe = UISwipeGestureRecognizer(target: self, action: #selector(self.responseGesture))
        rightSwipe .direction = UISwipeGestureRecognizer.Direction.right
        
        let leftSwipe = UISwipeGestureRecognizer(target: self, action: #selector(self.responseGesture))
        leftSwipe .direction = UISwipeGestureRecognizer.Direction.left
        self.view.addGestureRecognizer(rightSwipe)
        self.view.addGestureRecognizer(leftSwipe)
        
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
    @objc func slideTonext(){
        if currentIndex < displayImage.count - 1{
            currentIndex = currentIndex + 1
        }
        else{
            currentIndex = 0
        }
        myPageController.currentPage = currentIndex
        myCollection.scrollToItem(at: IndexPath(item: currentIndex, section: 0), at: .right, animated: true)
    }
    @objc
    private func messages(_ sender:UIBarButtonItem){
        print("messages")
    }
    func showMenu(){
        UIView.animate(withDuration: 0.3,delay: 0){  () -> Void in
            self.menus.view.frame = CGRect(x: 0, y: 60, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
            self.menus.view.backgroundColor = UIColor.black.withAlphaComponent(0.3)
            self.addChild(self.menus)
            self.view.addSubview(self.menus.view)
            
            
            AppDelegate.menu_bool = false
        }
    }
    func closeMenu(){
        UIView.animate(withDuration: 0.3,delay:0,animations: { () -> Void in
            self.menus.view.frame = CGRect(x: -UIScreen.main.bounds.width, y: 60, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        }){(Finished) in
            self.menus.view.removeFromSuperview()
        }
        
        AppDelegate.menu_bool = true
    }

    @IBAction func DepositTaaped(_ sender: Any) {
       
        performSegue(withIdentifier: "deposit", sender: self)
    }
    @IBAction func closingBtn(_ sender: Any) {
        self.dismiss(animated: true)
        print("close")
    }
    @IBAction func closings(_ sender: Any) {
        self.dismiss(animated: true)
        print("close")
    }
    @IBAction func SendTapped(_ sender: Any) {
       performSegue(withIdentifier: "sdending", sender: self)
    }
    @IBAction func withdrawTaped(_ sender: Any) {
        performSegue(withIdentifier: "withdraws", sender: self)
    }
    @IBAction func menu_icon(_ sender: UIBarButtonItem) {
        if AppDelegate.menu_bool{
            //opening side menu
            showMenu()
        }else{
            //clossing side menu
            closeMenu()
        }
    }
}
@available(iOS 13.0, *)
extension LipaViewController:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return displayImage.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = myCollection.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! MyCollectionViewCell
        cell.myImage.image = displayImage[indexPath.row]
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: myCollection.frame.width, height: myCollection.frame.height)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    
}
