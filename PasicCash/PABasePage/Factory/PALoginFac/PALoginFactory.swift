//
//  PALoginFactory.swift
//  PasicCash
//
//  Created by apple on 2024/7/3.
//

import UIKit
import DeviceKit

let PHONE_LOGIN = "PHONE_LOGIN"
let PHONE_SESSIONID = "PHONE_SESSIONID"

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
        let declared: String = PADeviceInfo().getIDFV() ?? ""
        let footbehind: String = UIDevice.current.systemVersion
        let walkflat: String = "siccs"
        var baffled: String = ""
        if let sessionId: String = UserDefaults.standard.object(forKey: PHONE_SESSIONID) as? String {
            baffled = sessionId
        }
        let period: String = PADeviceInfo().getIDFV() ?? ""
        let change: String = "pc"
        
        let dict = ["accomplished": accomplished,"seehow": seehow, "egyptians": egyptians, "declared": declared, "footbehind": footbehind, "walkflat": walkflat, "baffled": baffled, "period": period, "change": change]
        
        return dict
    }
    
    static func saveLoginInfo(_ phone: String, _ sessionID: String) {
        UserDefaults.standard.setValue(phone, forKey: PHONE_LOGIN)
        UserDefaults.standard.setValue(sessionID, forKey: PHONE_SESSIONID)
        UserDefaults.standard.synchronize()
    }
    
    static func removeLoginInfo() {
        UserDefaults.standard.setValue("", forKey: PHONE_LOGIN)
        UserDefaults.standard.setValue("", forKey: PHONE_SESSIONID)
        UserDefaults.standard.synchronize()
    }
}


extension PALoginFactory {
    
    
    
    
}
