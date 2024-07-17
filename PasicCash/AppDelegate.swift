//
//  AppDelegate.swift
//  PasicCash
//
//  Created by apple on 2024/7/2.
//

import UIKit
import IQKeyboardManagerSwift
import AppTrackingTransparency

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
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
}


extension AppDelegate: UNUserNotificationCenterDelegate {
    
    func jianPanManager(){
        let manager = IQKeyboardManager.shared
        manager.enable = true
        manager.shouldResignOnTouchOutside = true
        manager.keyboardDistanceFromTextField = 5.ppaix()
    }
    
    func rootVcPush() {
        NotificationCenter.default.addObserver(self, selector: #selector(setUpRootVc(_ :)), name: NSNotification.Name(ROOT_VC), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(huoquidfa(_ :)), name: NSNotification.Name(IDFA_PA), object: nil)
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
    
    @objc func huoquidfa(_ notification: Notification) {
        if #available(iOS 14.0, *) {
            ATTrackingManager.requestTrackingAuthorization { status in
                switch status {
                case .authorized:
                    print("Tracking authorized")
                    self.shangmarket()
                    break
                case .denied:
                    self.shangmarket()
                    print("Tracking denied")
                    break
                case .notDetermined:
                    print("Tracking not determined")
                    break
                case .restricted:
                    print("Tracking restricted")
                    break
                @unknown default:
                    print("Unknown status")
                    break
                }
            }
        }
    }
    
    func shangmarket() {
        let idfv = PADeviceInfo.getIDFV() ?? ""
        var idfaStr: String = ""
        PADeviceInfo.requestIDFA { idfa in
            idfaStr = idfa ?? ""
        }
        let dict = ["bitty": idfv, "themiddle": idfaStr, "sloshed": "1"]
        PARequestManager.shared.requestAPI(params: dict, pageUrl: "/sicch/jemAbout", method: .post) { baseModel in
            let handsto = baseModel.handsto
            if handsto == 0 || handsto == 00 {
                
            }
        } errorBlock: { error in
            
        }
        
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        var strToken = ""
        for byte in deviceToken {
            strToken += String(format: "%02x", byte)
        }
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        application.applicationIconBadgeNumber = 0
    }
    
}
