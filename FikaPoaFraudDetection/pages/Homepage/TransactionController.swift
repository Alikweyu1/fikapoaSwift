import UIKit
import LZViewPager

class TransactionController: UIViewController, LZViewPagerDelegate, LZViewPagerDataSource, UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        
    }
    
    @IBOutlet weak var paging: LZViewPager!
    private var subController: [UIViewController] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Transaction"
        viewpageProperties()
        
    }
    
    func viewpageProperties() {
        paging.delegate = self
        paging.dataSource = self
        paging.hostController = self
        let vc1 = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "TillTableViewController") as! TillTableViewController
        let vc2 = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "payBillController") as! payBillController
        let vc3 = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "withdraw2ViewController") as! withdraw2ViewController
        subController = [vc1, vc2,vc3]
      
        vc1.title = "All"
        vc2.title = "This week"
        vc3.title = "This Month"
        paging.reload()
    }
    
    func numberOfItems() -> Int {
        return subController.count
    }
    
    func controller(at index: Int) -> UIViewController {
        return subController[index]
    }
    
    func button(at index: Int) -> UIButton {
        let button = UIButton()
        button.setTitle(subController[index].title, for: .normal)
        button.setTitleColor(UIColor(red: 0.00, green: 0.00, blue: 0.00, alpha: 1.00), for: .normal)
        button.setTitleColor(UIColor(red: 0.00, green: 0.00, blue: 0.00, alpha: 1.00), for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        button.accessibilityLabel = subController[index].title
        return button
    }
    
    func colorForIndicator(at index: Int) -> UIColor {
        return .darkGray
    }
}

