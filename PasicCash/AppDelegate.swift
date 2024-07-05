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
        jianPanManager()
        rootVcPush()
        window?.rootViewController = PANavigationViewController(rootViewController: PALaunchViewController())
        window?.makeKeyAndVisible()
        return true
    }
    
}


extension AppDelegate {
    
    func jianPanManager(){
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.shouldResignOnTouchOutside = true
    }
    
    func rootVcPush() {
        NotificationCenter.default.addObserver(self, selector: #selector(setUpRootVc(_ :)), name: NSNotification.Name(ROOT_VC), object: nil)
    }
    
    @objc func setUpRootVc(_ notification: Notification) {
        if let userInfo = notification.userInfo {
            if let value = userInfo["login"] as? String {
                if value == "1" {
                    window?.rootViewController = PANavigationViewController(rootViewController: PATabBarViewController())
                }else{
                    window?.rootViewController = PANavigationViewController(rootViewController: PABorrowViewController())
                }
            }
        }
    }
}
