//
//  AppDelegate.swift
//  FikaPoaFraudDetection
//
//  Created by SOFTWARE on 02/03/2023.
//

import UIKit
import IQKeyboardManagerSwift
@available(iOS 13.0, *)
@main
class AppDelegate: UIResponder, UIApplicationDelegate {

   var window: UIWindow?
    static var menu_bool = true

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        //check()
        IQKeyboardManager.shared.enable = true
        return true
    }
    func check(){
        if UserDefaults.standard.value(forKey: "useremail") != nil{
            let hv = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier:"LipaViewController" ) as! LipaViewController
            let navVc = UINavigationController(rootViewController: hv)
            let share = UIApplication.shared.delegate as? AppDelegate
            share?.window?.rootViewController = navVc
            share?.window?.makeKeyAndVisible()
        }
    }
    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

