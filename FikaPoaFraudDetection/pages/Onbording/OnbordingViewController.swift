//
//  OnbordingViewController.swift
//  FikaPoaFraudDetection
//
//  Created by SOFTWARE on 29/03/2023.
//

import UIKit

@available(iOS 13.0, *)
class OnbordingViewController: UIViewController {

    //@IBOutlet weak var getstartedbtn: UIButton!
    @IBOutlet weak var collection2: UIView!
    @IBOutlet weak var pagecontroller: UIPageControl!
    @IBOutlet weak var skipbtn: UIButton!
    @IBOutlet weak var nextbtn: UIButton!
    @IBOutlet weak var collectionView: UICollectionView!
    var slides:[OnbordingSLide] = []
    var currentPage = 0 {
        didSet{
            pagecontroller.currentPage = currentPage
            if currentPage == slides.count - 1 {
                    self.nextbtn.setTitle("Get Started", for: .normal)
                    self.skipbtn.isHidden = true
              
            }else{
                
                    self.nextbtn.setTitle("Next", for: .normal)
                    self.skipbtn.isHidden = false
              
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.collectionViewLayout = UICollectionViewFlowLayout()
        (collectionView.collectionViewLayout as? UICollectionViewFlowLayout)?.scrollDirection = .horizontal
        slides = [
            OnbordingSLide(title: "Fikapoa", description: "testing", images: UIImage(named:"mpesa5" )!),
            OnbordingSLide(title: "Fikapoa", description: "testing", images: UIImage(named:"mpesa5" )!),
            OnbordingSLide(title: "Fikapoa", description: "testing", images: UIImage(named:"mpesa5" )!),
            OnbordingSLide(title: "Fikapoa", description: "testing", images: UIImage(named:"mpesa5" )!)
            
        ]
        
    }
    

    @IBAction func nextbtntapped(_ sender: UIButton) {
        if currentPage == slides.count - 1 {
            print("tapped")
          let mainview = storyboard?.instantiateViewController(withIdentifier:"ViewController" ) as! ViewController
            mainview.modalPresentationStyle = .fullScreen
            mainview.modalTransitionStyle = .flipHorizontal
            present(mainview, animated: true,completion: nil)
            
        } else{
           
            currentPage += 1
            let indexpath = IndexPath(item: currentPage, section: 0)
            collectionView.scrollToItem(at: indexpath, at: .left, animated: true)
        }
    }
    
    @IBAction func skippedbtnTapped(_ sender: Any) {
        let mainview = storyboard?.instantiateViewController(withIdentifier:"ViewController" ) as! ViewController
          mainview.modalPresentationStyle = .fullScreen
        mainview.modalTransitionStyle = .crossDissolve
          present(mainview, animated: true,completion: nil)
         
    }
    // MARK: - Navigation
    
    

}
@available(iOS 13.0, *)
extension OnbordingViewController:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return slides.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier:OnbordingCollectionViewCell.identifier, for: indexPath) as! OnbordingCollectionViewCell
        cell.setUp(slides[indexPath.row])
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let with = scrollView.frame.width
        currentPage = Int(scrollView.contentOffset.x/with)
       
    }
}

