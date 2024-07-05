//
//  AppDelegate.swift
//  PasicCash
//
//  Created by apple on 2024/7/2.
//

import UIKit
import IQKeyboardManagerSwift

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = PANavigationViewController(rootViewController: PALaunchViewController())
        jianPanManager()
        window?.makeKeyAndVisible()
        return true
    }
    
}


extension AppDelegate {
    
    func jianPanManager(){
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.shouldResignOnTouchOutside = true
    }
    
}
