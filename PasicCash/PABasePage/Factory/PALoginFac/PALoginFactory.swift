//
//  PALoginFactory.swift
//  PasicCash
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
        let accomplished: String = "iOS"
        let seehow: String = getAppVersion()
        let egyptians: String = Device.current.description
        let declared: String = PADeviceInfo.getIDFV() ?? ""
        let footbehind: String = UIDevice.current.systemVersion
        let walkflat: String = "siccs"
        var baffled: String = ""
        if let sessionId: String = UserDefaults.standard.object(forKey: PA_SESSIONID) as? String {
            baffled = sessionId
        }
        let period: String = PADeviceInfo.getIDFV() ?? ""
        let change: String = "pc"
        let peach = PADeviceInfo.vpnConnected()
        let basket = PADeviceInfo.usingProxy()
        
        let dict1 = ["accomplished": accomplished,
                    "seehow": seehow,
                    "egyptians": egyptians,
                    "declared": declared]
        
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
