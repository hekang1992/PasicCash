//
//  PALoginFactory.swift
//  Pesoin
//
//  Created by apple on 2024/7/3.
//

import UIKit
import DeviceKit

class PALoginFactory {
    
    static func getAppVersion() -> String {
        if let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String {
            return version
        }
        return "Version information not available"
    }

    static func getLoginParas() -> [String: String]{
        let footbehind: String = UIDevice.current.systemVersion
        var baffled: String = ""
        if let sessionId: String = UserDefaults.standard.object(forKey: PA_SESSIONID) as? String {
            baffled = sessionId
        }
        let walkflat: String = "siccs"
        let period: String = PADeviceInfo.getIDFV() ?? ""
        let basket = PADeviceInfo.usingProxy()
        let accomplished: String = "iOS"
        let change: String = "pc"
        let peach = PADeviceInfo.vpnConnected()
        let seehow: String = getAppVersion()
        let egyptians: String = Device.current.description
        let declared: String = PADeviceInfo.getIDFV() ?? ""
        let total = "14"
        let monthly = "8"
        let amount = "13"
        
        let dict1 = ["accomplished": accomplished,
                    "seehow": seehow,
                    "egyptians": egyptians,
                    "declared": declared,
                     "total": total,
                     "monthly": monthly,
                     "amount": amount]
        
        let dict2 = ["footbehind": footbehind,
                     "walkflat": walkflat,
                     "baffled": baffled,
                     "period": period,
                     "change": change,
                     "peach": peach,
                     "basket": basket]
        
        let allDict = dict2.reduce(into: dict1) { (result, item) in
            result[item.key] = item.value
        }
        return allDict
    }
    
    static func saveLoginInfo(_ phone: String, _ sessionID: String) {
        UserDefaults.standard.setValue(phone, forKey: PA_LOGIN)
        UserDefaults.standard.setValue(sessionID, forKey: PA_SESSIONID)
        UserDefaults.standard.synchronize()
    }
    
    static func removeLoginInfo() {
        UserDefaults.standard.setValue("", forKey: PA_LOGIN)
        UserDefaults.standard.setValue("", forKey: PA_SESSIONID)
        UserDefaults.standard.synchronize()
    }
}


extension PALoginFactory {
    
    
    
    
}
