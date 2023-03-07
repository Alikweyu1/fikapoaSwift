//
//  NetworkViewController.swift
//  FikaPoaFraudDetection
//
//  Created by SOFTWARE on 04/03/2023.
//

import UIKit
import Reachability
import MBProgressHUD

class NetworkViewController: UIViewController {

    var reachability: Reachability!

        override func viewDidLoad() {
            super.viewDidLoad()
            // Do any additional setup after loading the view.
            
            // Start monitoring network connectivity
            self.reachability = try! Reachability()
            NotificationCenter.default.addObserver(self, selector: #selector(networkStatusChanged(_:)), name: Notification.Name.reachabilityChanged, object: nil)
            try! self.reachability.startNotifier()
        }
        
        deinit {
            // Stop monitoring network connectivity
            NotificationCenter.default.removeObserver(self)
            self.reachability?.stopNotifier()
        }
        
        @objc func networkStatusChanged(_ notification: Notification) {
            let reachability = notification.object as! Reachability
            let networkStatus = reachability.connection
            
            if networkStatus == .unavailable {
                // Show MBProgressHUD with no network connectivity label
                showNoNetworkHUD()
            } else {
                // Hide MBProgressHUD if it is visible
                MBProgressHUD.hide(for: self.view, animated: true)
            }
        }
        
        func showNoNetworkHUD() {
            let hud = MBProgressHUD.showAdded(to: self.view, animated: true)
            hud.mode = .text
            hud.label.text = "No network connectivity"
            
            // Add an observer to listen for network connectivity changes
            NotificationCenter.default.addObserver(forName: Notification.Name.reachabilityChanged, object: nil, queue: .main) { notification in
                let reachability = notification.object as! Reachability
                let networkStatus = reachability.connection
                if networkStatus != .unavailable {
                    // Hide the HUD when network connectivity is available
                    hud.hide(animated: true)
                }
            }
            
            hud.show(animated: true)
        }
    }
